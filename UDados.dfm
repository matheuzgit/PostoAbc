object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 220
  Width = 535
  object FDconSYSCombo: TFDConnection
    Params.Strings = (
      'Database=D:\PostoAbc\Base\BDPOSTOABC.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Server=127.0.0.1'
      'Port=3050'
      'DriverID=FB')
    LoginPrompt = False
    Left = 248
    Top = 96
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    VendorLib = 'D:\Projetos\PostoAbc\FBCLIENT.DLL'
    Left = 80
    Top = 40
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 72
    Top = 136
  end
end
