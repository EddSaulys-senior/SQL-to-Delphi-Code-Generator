object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'SQLCodeGenerator by ///LisEd'
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
    ExplicitWidth = 1317
    object lblEditConnection: TLabel
      Left = 18
      Top = 19
      Width = 48
      Height = 15
      Caption = 'Connect:'
    end
    object SpeedButton1: TSpeedButton
      Left = 504
      Top = 13
      Width = 27
      Height = 26
      ImageIndex = 0
      Images = cxImageList1
      OnClick = SpeedButton1Click
    end
    object chbConnectToDB: TCheckBox
      Left = 544
      Top = 18
      Width = 130
      Height = 17
      Caption = 'Connect to SQLite'
      TabOrder = 0
    end
    object btnGenerateClick: TButton
      Left = 349
      Top = 14
      Width = 140
      Height = 25
      Caption = 'Convert SQL-Delphi'
      TabOrder = 1
      OnClick = btnGenerateClickClick
    end
    object chkUseTemp: TCheckBox
      Left = 246
      Top = 18
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
      Top = 15
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
    ExplicitWidth = 1317
    ExplicitHeight = 713
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
  object cxImageList1: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 25690768
    ImageInfo = <
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000018744558745469746C650044617461536F757263653B4F
          7074696F6E7318FCC056000002A749444154785E85915F48935118C69F6F4E6D
          E8226D54282462E63F50872093106B32A61888A05B7FA82C4923BAD09B8ABA30
          24E82E2F52B1F2A284C890C894946C1189A4A685CBF96722EACC744E73EAD86C
          FBBE734EFBD8846A931E38BC1CCEFBFE78CEF372F049D2FFA0AC5802E4714002
          63341E8C4B23948C53C2E689406608211F35B7BB3B0150E615FE9064B0416798
          EEAA634B9F5BD9CF890EE6B0F4326A1F645BD3EDCC36DCC82C863A666CAD62EF
          EA0AFBC47E717EE74801708CD1FC446D25C008403DDEE206E8362215B188888A
          06232EC4A4A460E5714BAE080040E1930F407802C1390F6944BCF80C0E140C14
          5422E0D7EA0FB8D71701F732082F40ECFFCBBE08A08482F29B105C360061E0ED
          0370589AB13A528FD9CE662CBCEF807B6D0144204101A03CC1FF05107F5F8003
          8108D85D1CE4F15990A796E2A8A63CB803C2D3C0B1109937931884EF3F0CD9A1
          2418C678B40C87E2EACD877739AF6AEE3C4575ED137F8842A03569641A363D32
          AC4639B1B44E316076E3824E8DC696379557AE370D6D3B5DC4ED768EFAB710F8
          0571C7AF3FB9C0ED39089B6D1325454AC4C52AA02FC9DD6BE81B6D5744CB3136
          39D7E30B91040FF1D03E0287C389AA722D8CC6299C2AAF85F1DB142E9DD160C3
          BE8135EB4ABF08A0CE6DBE7BA4FD0516478760FF3E230241F9759C504660D23C
          0F8F87C7C097699C56C7598DA639104A31F2758274B5DDBBCFF9530D6F3A9BA1
          97854A8A438023120992E3B20B43C7B714CC8A035CC5B902BCFD608469CA826C
          65225459496878F40A66F3EC2D6E2774FF46A462F5DF433425D52F95E9C99A65
          EB1AB4DA63484F4BC0DCEC229EB5F540BE37122693B9570C2BE81121D9C7CF27
          E4A82F9679EBE582D21B8EE71D7D4CA5AE7064AA745519393A7D6A6651E2AE80
          7F9C85E5155EABCF3F59C33254FA7A00E13B4E7F038A7C6509079C5294000000
          0049454E44AE426082}
        FileName = 'Images\Data\ManageDatasource_16x16.png'
        Keywords = 'Data;ManageDatasource'
      end>
  end
end
