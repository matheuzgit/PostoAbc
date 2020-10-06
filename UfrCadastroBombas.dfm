object FrmCadBombas: TFrmCadBombas
  Left = 0
  Top = 0
  Caption = 'Cadastro e Configura'#231#227'o de bombas'
  ClientHeight = 160
  ClientWidth = 348
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001002000680400001600000028000000100000002000
    00000100200000000000000400006F0000006F00000000000000000000001712
    0CE6433425E2433425E2433425E2433425E2433425E2433425E2433425E24334
    25E2433425E2433425E2433425E2433425E2433425E2433425E217120CE60B0C
    10F022263AE91E2230EB202538EA30261DDC392D20D6392D20D6392D20D62520
    23E523293EE823293EE823293EE822263AE92B231FDF392D20D61D1610D5091C
    47E21A54D6FF0D2B70EC1648B8FF020A166AFFFFFF00FFFFFF00FFFFFF000614
    32CA1E60F5FF1E60F5FF1E60F5FF1A54D6FF050F2798FFFFFF00FFFFFF00091C
    47E21A54D6FF0D2B70EC1648B8FF020A166AFFFFFF00FFFFFF00000000800209
    17E41E60F5FF1E60F5FF1E60F5FF1A54D6FF010308E000000055FFFFFF00091C
    47E21A54D6FF0D2B70EC1648B8FF020A166AFFFFFF00FFFFFF00000000A10511
    2BD11542A8FF1542A8FF1542A8FF123A93FF050F249A000000A1FFFFFF00091C
    47E21A54D6FF0D2B70EC1648B8FF020A166AFFFFFF00FFFFFF00000000A02A20
    17CF9E7B59FF9E7B59FF9E7B59FF8A6B4DFF231D1498000000A0FFFFFF00091C
    47E21A54D6FF0D2B70EC1648B8FF020A166A0000000100000005000000A03025
    1BCACD9F73FFD6A678FF806448FFC3986DFF231D1498000000A000000006091C
    47E21A54D6FF0D2B70EC1648B8FF020A166A00000019000000BD000000CE1E17
    11DBE1AF7EFFE5B280FFC89C70FFC99D71FF0B0806D6000000CD000000AA0E0D
    0EF0362E2FE92E2827EB292323EE0E0E116AFFFFFF00000000040000000B130E
    08E2473420E8473420E8473420E83E2C1CEB140E08B600000001000000031412
    0EF14C4236EB4C4236EB383127F016130E6AFFFFFF00FFFFFF00FFFFFF002015
    09C2432C14E24A3925E9483520E63A2612E51F130A85FFFFFF00FFFFFF004A4A
    43E2FFFFE6FFFFFFE6FFBFBFACFF1818166AFFFFFF00FFFFFF00FFFFFF00FFFF
    FF00000000105E5E54E43B3B35D0FFFFFF00FFFFFF00FFFFFF00FFFFFF004A4A
    43E2FFFFE6FFFFFFE6FFBFBFACFF1818166AFFFFFF00FFFFFF00FFFFFF00FFFF
    FF00000000105E5E54E43B3B35D0FFFFFF00FFFFFF00FFFFFF00FFFFFF004A4A
    43E2FFFFE6FFFFFFE6FFBFBFACFF1818166AFFFFFF00FFFFFF00FFFFFF00FFFF
    FF00000000105E5E54E43B3B35D0FFFFFF00FFFFFF00FFFFFF00FFFFFF001A19
    15EF625E54EB625E54EB47453EF016100ACE25190CAC25190CAC25190CAC2519
    0CAC23160AB122201CEF171511EC25190CAC25190CAC25190CAC20140A963E28
    13E3D88D42FFD88D42FFD88D42FFD88D42FFD88D42FFD88D42FFD88D42FFD88D
    42FFD88D42FFD88D42FFD88D42FFD88D42FFD88D42FFD88D42FF3A2612CC170E
    07E6432C14E2432C14E2432C14E2432C14E2432C14E2432C14E2432C14E2432C
    14E2432C14E2432C14E2432C14E2432C14E2432C14E1332210CC21150C560000
    0000000000000703000006010000060100000601000000000000000000000400
    000007030000078F0000078F0000078F0000000000000000000000000000}
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 348
    Height = 160
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 198
      Top = 13
      Width = 36
      Height = 13
      Caption = 'Tanque'
    end
    object Label2: TLabel
      Left = 16
      Top = 13
      Width = 32
      Height = 13
      Caption = 'Bomba'
    end
    object Label3: TLabel
      Left = 195
      Top = 59
      Width = 64
      Height = 13
      Caption = 'Valor por litro'
    end
    object Label4: TLabel
      Left = 16
      Top = 59
      Width = 39
      Height = 13
      Caption = 'Imposto'
    end
    object Meditimposto: TMaskEdit
      Left = 16
      Top = 78
      Width = 49
      Height = 21
      TabOrder = 0
      Text = '00,00%'
    end
    object MeditValor: TMaskEdit
      Left = 195
      Top = 78
      Width = 59
      Height = 21
      TabOrder = 1
      Text = '00,00'
    end
    object BtnConfirmar: TButton
      Left = 128
      Top = 116
      Width = 75
      Height = 25
      Caption = 'Confirmar'
      TabOrder = 2
      OnClick = BtnConfirmarClick
    end
    object EdtIdBomba: TEdit
      Left = 16
      Top = 32
      Width = 121
      Height = 21
      TabOrder = 3
    end
  end
  object DblkTanque: TDBLookupComboBox
    Left = 195
    Top = 32
    Width = 145
    Height = 21
    KeyField = 'ID_TANQUE'
    ListField = 'ID_TANQUE'
    ListSource = DsTanque
    TabOrder = 1
  end
  object QryBombas: TFDQuery
    Connection = DataModule1.FDconSYSCombo
    SQL.Strings = (
      '')
    Left = 64
    Top = 96
    object QryBombasBOMBA: TStringField
      FieldName = 'BOMBA'
      Origin = 'BOMBA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 10
    end
    object QryBombasID_TANQUE: TStringField
      FieldName = 'ID_TANQUE'
      Origin = 'ID_TANQUE'
      Required = True
    end
    object QryBombasIMPOSTO: TSingleField
      FieldName = 'IMPOSTO'
      Origin = 'IMPOSTO'
      Required = True
    end
    object QryBombasVALOR_LITRO: TSingleField
      FieldName = 'VALOR_LITRO'
      Origin = 'VALOR_LITRO'
      Required = True
    end
  end
  object QryTanque: TFDQuery
    Connection = DataModule1.FDconSYSCombo
    SQL.Strings = (
      'select * from TBTANQUE')
    Left = 248
    Top = 115
    object StringField1: TStringField
      FieldName = 'ID_TANQUE'
      Origin = 'ID_TANQUE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object StringField2: TStringField
      FieldName = 'TIPO_COMBUSTIVEL'
      Origin = 'TIPO_COMBUSTIVEL'
      Required = True
    end
    object SingleField1: TSingleField
      FieldName = 'LITROS'
      Origin = 'LITROS'
      Required = True
    end
  end
  object DsTanque: TDataSource
    DataSet = QryTanque
    Left = 288
    Top = 72
  end
end
