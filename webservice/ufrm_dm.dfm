object frm_dm: Tfrm_dm
  OldCreateOrder = False
  Encoding = esASCII
  Height = 416
  Width = 557
  object connDB: TFDConnection
    Params.Strings = (
      'Database=dbcloud'
      'User_Name=root'
      'Password=root'
      'Server=localhost'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 40
    Top = 24
  end
  object rdwDriver: TRESTDWDriverFD
    CommitRecords = 100
    Connection = connDB
    Left = 40
    Top = 80
  end
  object poolerDB: TRESTDWPoolerDB
    RESTDriver = rdwDriver
    Compression = True
    Encoding = esUtf8
    StrsTrim = False
    StrsEmpty2Null = False
    StrsTrim2Len = True
    Active = True
    PoolerOffMessage = 'RESTPooler not active.'
    ParamCreate = True
    Left = 40
    Top = 136
  end
  object mysqlDriver: TFDPhysMySQLDriverLink
    VendorLib = 'C:\ccsolutions_wbs\lib\libmysql.dll'
    Left = 104
    Top = 24
  end
  object waitCursor: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 168
    Top = 24
  end
end
