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
  Height = 333
  Width = 414
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
    Left = 192
    Top = 59
  end
  object dsserverclass: TDSServerClass
    OnGetClass = dsserverclassGetClass
    Server = dsserver
    Left = 192
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
    Left = 192
    Top = 104
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
    Left = 192
    Top = 152
  end
end
