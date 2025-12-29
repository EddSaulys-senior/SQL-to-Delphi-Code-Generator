object DBGrid: TDBGrid
  Left = 0
  Top = 0
  Caption = 'DbGrid'
  ClientHeight = 569
  ClientWidth = 932
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poOwnerFormCenter
  TextHeight = 15
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 0
    Width = 932
    Height = 569
    Align = alClient
    DataSource = UniDataSource1
    DrawMemoText = True
    DynProps = <>
    TabOrder = 0
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object UniConnection1: TUniConnection
    Left = 808
    Top = 32
  end
  object UniQuery1: TUniQuery
    Connection = UniConnection1
    Left = 808
    Top = 96
  end
  object UniDataSource1: TUniDataSource
    DataSet = UniQuery1
    Left = 808
    Top = 168
  end
  object SQLiteUniProvider1: TSQLiteUniProvider
    Left = 808
    Top = 240
  end
end
