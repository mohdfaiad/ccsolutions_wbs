object frm_webmodule: Tfrm_webmodule
  OldCreateOrder = False
  OnCreate = WebModuleCreate
  Actions = <
    item
      Name = 'ReverseStringAction'
      PathInfo = '/ReverseString'
      Producer = reversestring
    end
    item
      Name = 'ServerFunctionInvokerAction'
      PathInfo = '/ServerFunctionInvoker'
      Producer = serverfunction
    end
    item
      Default = True
      Name = 'DefaultAction'
      PathInfo = '/'
      OnAction = WebModuleDefaultAction
    end>
  BeforeDispatch = WebModuleBeforeDispatch
  Height = 519
  Width = 586
  object dsserver: TDSServer
    Left = 48
    Top = 11
  end
  object dshttpweb: TDSHTTPWebDispatcher
    DSContext = 'api/'
    Server = dsserver
    Filters = <>
    AuthenticationManager = dsauthentication
    WebDispatch.PathInfo = 'api*'
    Left = 48
    Top = 59
  end
  object dsauthentication: TDSAuthenticationManager
    OnUserAuthenticate = dsauthenticationUserAuthenticate
    OnUserAuthorize = dsauthenticationUserAuthorize
    Roles = <>
    Left = 48
    Top = 251
  end
  object dsserverclass: TDSServerClass
    OnGetClass = dsserverclassGetClass
    Server = dsserver
    Left = 160
    Top = 11
  end
  object serverfunction: TPageProducer
    HTMLFile = 'templates/serverfunctioninvoker.html'
    OnHTMLTag = serverfunctionHTMLTag
    Left = 48
    Top = 152
  end
  object reversestring: TPageProducer
    HTMLFile = 'templates/reversestring.html'
    OnHTMLTag = serverfunctionHTMLTag
    Left = 48
    Top = 296
  end
  object webfile: TWebFileDispatcher
    WebFileExtensions = <
      item
        MimeType = 'text/css'
        Extensions = 'css'
      end
      item
        MimeType = 'text/javascript'
        Extensions = 'js'
      end
      item
        MimeType = 'image/x-png'
        Extensions = 'png'
      end
      item
        MimeType = 'text/html'
        Extensions = 'htm;html'
      end
      item
        MimeType = 'image/jpeg'
        Extensions = 'jpg;jpeg;jpe'
      end
      item
        MimeType = 'image/gif'
        Extensions = 'gif'
      end>
    BeforeDispatch = webfileBeforeDispatch
    WebDirectories = <
      item
        DirectoryAction = dirInclude
        DirectoryMask = '*'
      end
      item
        DirectoryAction = dirExclude
        DirectoryMask = '\templates\*'
      end>
    RootDirectory = '.'
    VirtualPath = '/'
    Left = 48
    Top = 104
  end
  object dsproxygenerator: TDSProxyGenerator
    ExcludeClasses = 'DSMetadata'
    MetaDataProvider = dsserverprovider
    Writer = 'Java Script REST'
    Left = 48
    Top = 200
  end
  object dsserverprovider: TDSServerMetaDataProvider
    Server = dsserver
    Left = 48
    Top = 344
  end
  object dssc_phonebook: TDSServerClass
    OnGetClass = dssc_phonebookGetClass
    Server = dsserver
    Left = 160
    Top = 59
  end
  object dssc_contract: TDSServerClass
    OnGetClass = dssc_contractGetClass
    Server = dsserver
    Left = 160
    Top = 107
  end
  object dssc_enterprise: TDSServerClass
    OnGetClass = dssc_enterpriseGetClass
    Server = dsserver
    Left = 160
    Top = 155
  end
  object dssc_contract_user: TDSServerClass
    OnGetClass = dssc_contract_userGetClass
    Server = dsserver
    Left = 160
    Top = 203
  end
  object dssc_client: TDSServerClass
    OnGetClass = dssc_clientGetClass
    Server = dsserver
    Left = 160
    Top = 251
  end
  object dssc_login: TDSServerClass
    OnGetClass = dssc_loginGetClass
    Server = dsserver
    Left = 160
    Top = 299
  end
  object dssc_reseller: TDSServerClass
    OnGetClass = dssc_resellerGetClass
    Server = dsserver
    Left = 160
    Top = 347
  end
  object dssc_product: TDSServerClass
    OnGetClass = dssc_productGetClass
    Server = dsserver
    Left = 264
    Top = 11
  end
  object dssc_client_contract: TDSServerClass
    OnGetClass = dssc_client_contractGetClass
    Server = dsserver
    Left = 264
    Top = 59
  end
  object dssc_client_contract_iten: TDSServerClass
    OnGetClass = dssc_client_contract_itenGetClass
    Server = dsserver
    Left = 264
    Top = 107
  end
  object dssc_voip_server: TDSServerClass
    OnGetClass = dssc_voip_serverGetClass
    Server = dsserver
    Left = 264
    Top = 155
  end
  object dssc_client_astpp: TDSServerClass
    OnGetClass = dssc_client_astppGetClass
    Server = dsserver
    Left = 264
    Top = 203
  end
  object dssc_client_sippulse: TDSServerClass
    OnGetClass = dssc_client_sippulseGetClass
    Server = dsserver
    Left = 264
    Top = 251
  end
  object dssc_print_astpp: TDSServerClass
    OnGetClass = dssc_print_astppGetClass
    Server = dsserver
    Left = 264
    Top = 299
  end
  object dssc_supplier: TDSServerClass
    OnGetClass = dssc_supplierGetClass
    Server = dsserver
    Left = 264
    Top = 347
  end
  object dssc_ticket_type: TDSServerClass
    OnGetClass = dssc_ticket_typeGetClass
    Server = dsserver
    Left = 344
    Top = 11
  end
  object dssc_ticket_priority: TDSServerClass
    OnGetClass = dssc_ticket_priorityGetClass
    Server = dsserver
    Left = 344
    Top = 59
  end
  object dssc_ticket_category: TDSServerClass
    OnGetClass = dssc_ticket_categoryGetClass
    Server = dsserver
    Left = 344
    Top = 107
  end
  object dssc_ticket_category_sub: TDSServerClass
    OnGetClass = dssc_ticket_category_subGetClass
    Server = dsserver
    Left = 344
    Top = 155
  end
end
