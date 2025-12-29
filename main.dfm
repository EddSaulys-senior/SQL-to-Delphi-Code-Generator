object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'SQLCodeGenerator'
  ClientHeight = 766
  ClientWidth = 1321
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1321
    Height = 52
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lblEditConnection: TLabel
      Left = 18
      Top = 19
      Width = 48
      Height = 15
      Caption = 'Connect:'
    end
    object chbConnectToDB: TCheckBox
      Left = 512
      Top = 18
      Width = 146
      Height = 17
      Caption = 'Connect to SQLite'
      TabOrder = 0
      OnClick = chbConnectToDBClick
    end
    object btnGenerateClick: TButton
      Left = 349
      Top = 14
      Width = 131
      Height = 25
      Caption = 'Convert SQL-Delphi'
      TabOrder = 1
      OnClick = btnGenerateClickClick
    end
    object chkUseTemp: TCheckBox
      Left = 246
      Top = 19
      Width = 97
      Height = 17
      Caption = 'Create/Free'
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = chkUseTempClick
    end
    object UniConnectionUnit: TEdit
      Left = 72
      Top = 16
      Width = 153
      Height = 23
      TabOrder = 3
      Text = 'UniQuery1'
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 52
    Width = 1321
    Height = 714
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 42
    ExplicitHeight = 725
    object memsource: TSynEdit
      Left = 18
      Top = 6
      Width = 640
      Height = 682
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Consolas'
      Font.Style = []
      Font.Quality = fqClearTypeNatural
      TabOrder = 0
      UseCodeFolding = False
      Gutter.Font.Charset = DEFAULT_CHARSET
      Gutter.Font.Color = clWindowText
      Gutter.Font.Height = -11
      Gutter.Font.Name = 'Consolas'
      Gutter.Font.Style = []
      Gutter.ShowLineNumbers = True
      Gutter.Bands = <
        item
          Kind = gbkMarks
          Width = 13
        end
        item
          Kind = gbkLineNumbers
        end
        item
          Kind = gbkFold
        end
        item
          Kind = gbkTrackChanges
        end
        item
          Kind = gbkMargin
          Width = 3
        end>
      Highlighter = SynSQLSyn1
      SelectedColor.Alpha = 0.400000005960464500
    end
    object memTarget: TSynEdit
      Left = 664
      Top = 6
      Width = 640
      Height = 682
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Consolas'
      Font.Style = []
      Font.Quality = fqClearTypeNatural
      TabOrder = 1
      OnDblClick = memTargetDblClick
      UseCodeFolding = False
      Gutter.Font.Charset = DEFAULT_CHARSET
      Gutter.Font.Color = clWindowText
      Gutter.Font.Height = -11
      Gutter.Font.Name = 'Consolas'
      Gutter.Font.Style = []
      Gutter.ShowLineNumbers = True
      Gutter.Bands = <
        item
          Kind = gbkMarks
          Width = 13
        end
        item
          Kind = gbkLineNumbers
        end
        item
          Kind = gbkFold
        end
        item
          Kind = gbkTrackChanges
        end
        item
          Kind = gbkMargin
          Width = 3
        end>
      Highlighter = SynPasSyn1
      SelectedColor.Alpha = 0.400000005960464500
    end
  end
  object SynSQLSyn1: TSynSQLSyn
    Left = 736
    Top = 480
  end
  object SynPasSyn1: TSynPasSyn
    Left = 664
    Top = 480
  end
end
