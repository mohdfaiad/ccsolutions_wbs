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
  Height = 535
  Width = 638
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
  object phonebook: TDSServerClass
    OnGetClass = phonebookGetClass
    Server = dsserver
    Left = 160
    Top = 59
  end
  object contract: TDSServerClass
    OnGetClass = contractGetClass
    Server = dsserver
    Left = 160
    Top = 107
  end
  object enterprise: TDSServerClass
    OnGetClass = enterpriseGetClass
    Server = dsserver
    Left = 160
    Top = 155
  end
  object contract_user: TDSServerClass
    OnGetClass = contract_userGetClass
    Server = dsserver
    Left = 160
    Top = 203
  end
  object cliente: TDSServerClass
    OnGetClass = clienteGetClass
    Server = dsserver
    Left = 160
    Top = 251
  end
  object login: TDSServerClass
    OnGetClass = loginGetClass
    Server = dsserver
    Left = 160
    Top = 299
  end
  object reseller: TDSServerClass
    OnGetClass = resellerGetClass
    Server = dsserver
    Left = 160
    Top = 347
  end
  object product: TDSServerClass
    OnGetClass = productGetClass
    Server = dsserver
    Left = 256
    Top = 11
  end
  object client_contract: TDSServerClass
    OnGetClass = client_contractGetClass
    Server = dsserver
    Left = 256
    Top = 59
  end
  object client_contract_iten: TDSServerClass
    OnGetClass = client_contract_itenGetClass
    Server = dsserver
    Left = 256
    Top = 107
  end
  object voip_server: TDSServerClass
    OnGetClass = voip_serverGetClass
    Server = dsserver
    Left = 256
    Top = 155
  end
  object client_astpp: TDSServerClass
    OnGetClass = client_astppGetClass
    Server = dsserver
    Left = 256
    Top = 203
  end
  object client_sippulse: TDSServerClass
    OnGetClass = client_sippulseGetClass
    Server = dsserver
    Left = 256
    Top = 251
  end
  object print_astpp: TDSServerClass
    OnGetClass = print_astppGetClass
    Server = dsserver
    Left = 256
    Top = 299
  end
  object supplier: TDSServerClass
    OnGetClass = supplierGetClass
    Server = dsserver
    Left = 256
    Top = 347
  end
  object ticket_type: TDSServerClass
    OnGetClass = ticket_typeGetClass
    Server = dsserver
    Left = 352
    Top = 11
  end
  object ticket_priority: TDSServerClass
    OnGetClass = ticket_priorityGetClass
    Server = dsserver
    Left = 352
    Top = 59
  end
  object ticket_category: TDSServerClass
    OnGetClass = ticket_categoryGetClass
    Server = dsserver
    Left = 352
    Top = 107
  end
  object ticket_category_sub: TDSServerClass
    OnGetClass = ticket_category_subGetClass
    Server = dsserver
    Left = 352
    Top = 155
  end
  object material: TDSServerClass
    OnGetClass = materialGetClass
    Server = dsserver
    Left = 352
    Top = 203
  end
  object medicine: TDSServerClass
    OnGetClass = medicineGetClass
    Server = dsserver
    Left = 352
    Top = 251
  end
  object insurance: TDSServerClass
    OnGetClass = insuranceGetClass
    Server = dsserver
    Left = 352
    Top = 299
  end
  object table_price: TDSServerClass
    OnGetClass = table_priceGetClass
    Server = dsserver
    Left = 352
    Top = 347
  end
  object did: TDSServerClass
    OnGetClass = didGetClass
    Server = dsserver
    Left = 456
    Top = 11
  end
  object provider: TDSServerClass
    OnGetClass = providerGetClass
    Server = dsserver
    Left = 456
    Top = 59
  end
  object client_did: TDSServerClass
    OnGetClass = client_didGetClass
    Server = dsserver
    Left = 456
    Top = 107
  end
  object proposal_contract: TDSServerClass
    OnGetClass = proposal_contractGetClass
    Server = dsserver
    Left = 456
    Top = 155
  end
  object proposal_contract_iten: TDSServerClass
    OnGetClass = proposal_contract_itenGetClass
    Server = dsserver
    Left = 456
    Top = 203
  end
  object ticket: TDSServerClass
    OnGetClass = ticketGetClass
    Server = dsserver
    Left = 456
    Top = 251
  end
end
