unit fConnect;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.IOUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls;

type
  TConnection = class(TForm)
    LabeledEdit1: TLabeledEdit;
    Bevel1: TBevel;
    dbPath: TLabeledEdit;
    btnConnect: TButton;
    btnDisconnect: TButton;
    lblConnected: TLabel;
    procedure btnConnectClick(Sender: TObject);
    procedure btnDisconnectClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Connection: TConnection;

implementation

{$R *.dfm}

uses fGrid, main;

procedure TConnection.btnConnectClick(Sender: TObject);
var
  CleanPath: string;
begin
  CleanPath := Trim(dbPath.Text);

  // 1. Проверка пути
  if CleanPath = '' then Exit;

  // 2. Проверка существования файла
  if not TFile.Exists(CleanPath) then
  begin
    ShowMessage('Error: The database file was not found at:' + sLineBreak + CleanPath);
    Exit;
  end;

  // 3. Настройка подключения
  DBGrid.UniConnection1.Connected := False; // На всякий случай разрываем старое
  DBGrid.UniConnection1.ProviderName := 'SQLite';
  DBGrid.UniConnection1.Database := CleanPath;

  // 4. Попытка подключения с обработкой ошибок
  Screen.Cursor := crHourGlass; // Показываем курсор ожидания
  try
    try
      DBGrid.UniConnection1.Connect;
      // Если у тебя есть связанные Query, можно их тут открыть
      DBGrid.UniQuery1.SQL.Text := 'SELECT name FROM sqlite_master WHERE type="table"';
      DBGrid.UniQuery1.Open;
      lblConnected.Caption := 'Connected';
      ShowMessage('Tables found in the database: ' + IntToStr(DBGrid.UniQuery1.RecordCount));
    except
      on E: Exception do
        ShowMessage('Couldn''t connect to the database!' + sLineBreak + E.Message);
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;


procedure TConnection.btnDisconnectClick(Sender: TObject);
begin
  // 1. Проверяем, подключены ли мы вообще
  if not DBGrid.UniConnection1.Connected then
  begin
   // ShowMessage('The connection has already been terminated.');
    Exit;
  end;

  try
    // 2. Закрываем все активные запросы, связанные с этим соединением
    // Это хорошая практика, чтобы избежать "зависших" курсоров
    DBGrid.UniQuery1.Close;
    lblConnected.Caption := 'Disconnected';
    // Если таблиц/запросов много, можно использовать цикл по компонентам:
    // for i := 0 to DBGrid.ComponentCount - 1 do
    //   if DBGrid.Components[i] is TCustomDADataSet then
    //     TCustomDADataSet(DBGrid.Components[i]).Close;

    // 3. Разрываем основное соединение
    DBGrid.UniConnection1.Disconnect; // или .Connected := False;

    ShowMessage('The database has been successfully disabled.');
  except
    on E: Exception do
      ShowMessage('Error when disconnecting: ' + E.Message);
  end;
end;


end.
