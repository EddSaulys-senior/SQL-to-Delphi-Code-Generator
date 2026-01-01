unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.RegularExpressions, DBGridEh,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, SynEdit,
  SynEditCodeFolding, SynHighlighterPas, SynEditHighlighter, SynHighlighterSQL,
  Vcl.ExtCtrls, Vcl.Buttons, System.ImageList, Vcl.ImgList, cxImageList,
  cxGraphics, DFCodeFormatting, SynEditTypes;

type
  // Объявляем вспомогательный класс
  TDBGridEhHack = class(TDBGridEh);

  TForm1 = class(TForm)
    SynSQLSyn1: TSynSQLSyn;
    SynPasSyn1: TSynPasSyn;
    Panel1: TPanel;
    chbConnectToDB: TCheckBox;
    btnGenerateClick: TButton;
    chkUseTemp: TCheckBox;
    UniConnectionUnit: TEdit;
    lblEditConnection: TLabel;
    Panel2: TPanel;
    memsource: TSynEdit;
    memTarget: TSynEdit;
    SpeedButton1: TSpeedButton;
    cxImageList1: TcxImageList;
    procedure btnGenerateClickClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure memTargetDblClick(Sender: TObject);
    procedure chkUseTempClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    procedure SetupHighlighter;
    procedure SetDialectByProvider(const ProviderName: string);
    procedure SetupPascalHighlighter;
    procedure SetupResultEditor;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses fConnect, fGrid;

procedure FormatSql_SynEditSafe(ASyn: TSynEdit);
var
  OldOptions: TSynEditorOptions;
  OldCaret: TBufferCoord;
  OldTop: Integer;
  SOut: string;
begin
  OldOptions := ASyn.Options;
  OldCaret := ASyn.CaretXY;
  OldTop := ASyn.TopLine;

  // Важно: временно убираем авто-отступы/умные табы
  ASyn.Options := ASyn.Options - [eoAutoIndent, eoSmartTabs, eoTabsToSpaces];

  SOut := TCodeFormatter.FormatSQL(ASyn.Lines.Text,
    TCodeFormatter.TIndentationType.Spaces, 2);

  ASyn.BeginUpdate;
  try
    // Самая "чистая" замена — через Lines.Text (без SelText)
    ASyn.Lines.Text := SOut;

    ASyn.CaretXY := OldCaret;
    ASyn.TopLine := OldTop;
  finally
    ASyn.EndUpdate;
    ASyn.Options := OldOptions; // вернуть как было
  end;
end;

function GenerateEliteSQLCode(const ASQL, AConnectionOrQueryName: string; AUseTemp: Boolean): string;
var
  SL, Params: TStringList;
  I: Integer;
  Line, ParamName, QName, Indent: string;
  Match: TMatch;
begin
  SL := TStringList.Create;
  Params := TStringList.Create;
  Params.Sorted := True;
  Params.Duplicates := dupIgnore;
  try
    SL.Text := ASQL;

    // Поиск параметров через RegEx
    for Match in TRegEx.Matches(ASQL, ':[a-zA-Z0-9_]+') do
    begin
      ParamName := Copy(Match.Value, 2, Length(Match.Value));
      Params.Add(ParamName);
    end;

    // Настройка префикса и отступов
    if AUseTemp then
    begin
      QName := 'qTmp';
      Indent := '    ';
      Result := 'var' + sLineBreak +
                '  ' + QName + ': TUniQuery;' + sLineBreak +
                'begin' + sLineBreak +
                '  ' + QName + ' := TUniQuery.Create(nil);' + sLineBreak +
                '  try' + sLineBreak +
                '    ' + QName + '.Connection := ' + AConnectionOrQueryName + ';' + sLineBreak;
    end
    else
    begin
      QName := AConnectionOrQueryName;
      Indent := '  ';
      Result := '// SQL Block for ' + QName + sLineBreak;
    end;

    // Основной блок SQL
    Result := Result + Indent + QName + '.SQL.BeginUpdate;' + sLineBreak;
    Result := Result + Indent + 'try' + sLineBreak;
    Result := Result + Indent + '  ' + QName + '.SQL.Clear;' + sLineBreak;

    for I := 0 to SL.Count - 1 do
    begin
      Line := SL[I];
      if Trim(Line) = '' then Continue;
      Line := StringReplace(Line, '''', '''''', [rfReplaceAll]);
      Result := Result + Indent + '  ' + QName + '.SQL.Add(''' + Line + ''');' + sLineBreak;
    end;

    Result := Result + Indent + 'finally' + sLineBreak;
    Result := Result + Indent + '  ' + QName + '.SQL.EndUpdate;' + sLineBreak;
    Result := Result + Indent + 'end;' + sLineBreak + sLineBreak;

    // Параметры
    if Params.Count > 0 then
    begin
      Result := Result + Indent + '// Setup Parameters' + sLineBreak;
      for I := 0 to Params.Count - 1 do
        Result := Result + Indent + QName + '.ParamByName(''' + Params[I] + ''').Value := ;' + sLineBreak;
      Result := Result + sLineBreak;
    end;

    // Завершение
    Result := Result + Indent + QName + '.Open; // or .ExecSQL' + sLineBreak;

    if AUseTemp then
    begin
      Result := Result + '  finally' + sLineBreak +
                '    ' + QName + '.Free;' + sLineBreak +
                '  end;' + sLineBreak +
                'end;';
    end;

  finally
    SL.Free;
    Params.Free;
  end;
end;

procedure OptimizeGrid(Grid: TDBGridEh);
var
  i: Integer;
begin
  // Приводим тип к хак-классу, чтобы вызвать защищенный метод
  TDBGridEhHack(Grid).LayoutChanged;

  for i := 0 to Grid.Columns.Count - 1 do
  begin
    Grid.Columns[i].OptimizeWidth;
    Grid.Columns[i].Title.Alignment := taCenter;
  end;
end;

procedure TForm1.btnGenerateClickClick(Sender: TObject);
var
  MinifiedSQL: string;
begin
  if memSource.Text = '' then
    Exit;

  MinifiedSQL := TCodeFormatter.MinifySQL(memsource.Lines.Text);
  memsource.Lines.Text := MinifiedSQL;

  // Вызываем функцию с учетом состояния чекбокса
  memTarget.Text := GenerateEliteSQLCode(memsource.Text, UniConnectionUnit.Text,
    chkUseTemp.Checked);

  memTarget.SelectAll;
  memTarget.CopyToClipboard;

  if chbConnectToDB.Checked then
  begin
    DBGrid.UniQuery1.SQL.Text := memSource.Text;
    DBGrid.UniQuery1.Open;
    OptimizeGrid(DBGrid.DBGridEh1);
    DBGrid.Show;
  end;
end;

procedure TForm1.SetupHighlighter;
begin
  // Настраиваем подсветку синтаксиса
  SynSQLSyn1.SQLDialect := sqlStandard; // По умолчанию стандартный SQL

  // Цветовая схема (можно настроить под "темную" или "светлую" тему)
  SynSQLSyn1.KeyAttri.Foreground := clBlue;       // Ключевые слова (SELECT, FROM)
  SynSQLSyn1.KeyAttri.Style := [fsBold];

  SynSQLSyn1.StringAttri.Foreground := clNavy;    // Строки в кавычках
  SynSQLSyn1.NumberAttri.Foreground := clRed;     // Числа
  SynSQLSyn1.CommentAttri.Foreground := clGreen;  // Комментарии
  SynSQLSyn1.CommentAttri.Style := [fsItalic];

  SynSQLSyn1.SymbolAttri.Foreground := clMaroon;  // Символы (=, <>, ||)

  // Добавляем поддержку параметров UniDAC (те, что с двоеточием)
  // В SynEdit параметры часто подсвечиваются как переменные (Variables)
  SynSQLSyn1.VariableAttri.Foreground := clTeal;
  SynSQLSyn1.VariableAttri.Style := [fsBold];
end;

procedure TForm1.chkUseTempClick(Sender: TObject);
begin
  if chkUseTemp.Checked then
    lblEditConnection.Caption := 'Connect:'
      else
    lblEditConnection.Caption := 'Query:';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
SetupHighlighter;
SetDialectByProvider('SQLite');
SetupResultEditor;
SetupPascalHighlighter;
end;

procedure TForm1.memTargetDblClick(Sender: TObject);
begin
  memTarget.CopyToClipboard;
end;

procedure TForm1.SetDialectByProvider(const ProviderName: string);
begin
  if SameText(ProviderName, 'PostgreSQL') then
    SynSQLSyn1.SQLDialect := sqlPostgres
  else if SameText(ProviderName, 'MySQL') then
    SynSQLSyn1.SQLDialect := sqlMySQL
  else if SameText(ProviderName, 'Interbase') or SameText(ProviderName, 'Firebird') then
    SynSQLSyn1.SQLDialect := sqlInterbase6
  else
    SynSQLSyn1.SQLDialect := sqlStandard;
end;

procedure TForm1.SetupPascalHighlighter;
begin
  // Основные настройки подсветки Pascal
  SynPasSyn1.KeyAttri.Foreground := clNavy;      // begin, end, try, finally, for
  SynPasSyn1.KeyAttri.Style := [fsBold];

  SynPasSyn1.StringAttri.Foreground := clBlue;   // Текст SQL внутри кавычек в Delphi

  SynPasSyn1.NumberAttri.Foreground := clRed;    // Числа

  SynPasSyn1.CommentAttri.Foreground := clGreen; // Комментарии // и { }
  SynPasSyn1.CommentAttri.Style := [fsItalic];

  SynPasSyn1.DirectiveAttri.Foreground := clOlive; // Директивы {$R *.dfm}

  // Чтобы методы UniDAC (SQL, Add, Clear) выделялись, можно настроить Identifier
  SynPasSyn1.IdentifierAttri.Foreground := clBlack;
end;

procedure TForm1.SetupResultEditor;
begin
  memTarget.Highlighter := SynPasSyn1;
  memTarget.ReadOnly := True; // Чтобы пользователь случайно не стер сгенерированный код

  // Внешний вид
  memTarget.Font.Name := 'Consolas';
  memTarget.Font.Size := 10;

  // Показываем номера строк (удобно для длинных SQL)
  memTarget.Gutter.ShowLineNumbers := True;

  // Подсветка текущей строки
  memTarget.ActiveLineColor := $00E6FAFF; // Очень бледный желтый

  // Отключаем лишние символы
  memTarget.Options := memTarget.Options - [eoShowSpecialChars];
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  Connection.ShowModal;
end;

end.
