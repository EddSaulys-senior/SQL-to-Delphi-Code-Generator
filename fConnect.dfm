object Connection: TConnection
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Connect'
  ClientHeight = 173
  ClientWidth = 397
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object Bevel1: TBevel
    Left = 10
    Top = 9
    Width = 377
    Height = 105
    Shape = bsFrame
  end
  object lblConnected: TLabel
    Left = 10
    Top = 135
    Width = 123
    Height = 15
    Alignment = taCenter
    Caption = 'Disconnected'
  end
  object LabeledEdit1: TLabeledEdit
    Left = 112
    Top = 29
    Width = 249
    Height = 23
    EditLabel.Width = 49
    EditLabel.Height = 23
    EditLabel.BiDiMode = bdLeftToRight
    EditLabel.Caption = 'Provider*'
    EditLabel.ParentBiDiMode = False
    LabelPosition = lpLeft
    LabelSpacing = 30
    ReadOnly = True
    TabOrder = 0
    Text = 'SQLite'
  end
  object dbPath: TLabeledEdit
    Left = 112
    Top = 69
    Width = 249
    Height = 23
    EditLabel.Width = 48
    EditLabel.Height = 23
    EditLabel.BiDiMode = bdRightToLeft
    EditLabel.Caption = 'Database'
    EditLabel.ParentBiDiMode = False
    LabelPosition = lpLeft
    LabelSpacing = 30
    TabOrder = 1
    Text = ''
  end
  object btnConnect: TButton
    Left = 139
    Top = 131
    Width = 120
    Height = 25
    Caption = 'Connect'
    TabOrder = 2
    OnClick = btnConnectClick
  end
  object btnDisconnect: TButton
    Left = 266
    Top = 131
    Width = 120
    Height = 25
    Caption = 'Disconneect'
    TabOrder = 3
    OnClick = btnDisconnectClick
  end
end
