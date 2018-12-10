object frm_wbmodule: Tfrm_wbmodule
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
  Height = 481
  Width = 560
  object dsserver: TDSServer
    Left = 56
    Top = 11
  end
  object webdispatcher: TDSHTTPWebDispatcher
    Server = dsserver
    Filters = <>
    AuthenticationManager = authenticationmanager
    WebDispatch.PathInfo = 'datasnap*'
    Left = 56
    Top = 59
  end
  object authenticationmanager: TDSAuthenticationManager
    OnUserAuthenticate = authenticationmanagerUserAuthenticate
    OnUserAuthorize = authenticationmanagerUserAuthorize
    Roles = <>
    Left = 56
    Top = 307
  end
  object DSServerClass1: TDSServerClass
    OnGetClass = DSServerClass1GetClass
    Server = dsserver
    Left = 56
    Top = 259
  end
  object serverfunction: TPageProducer
    HTMLFile = 'templates/serverfunctioninvoker.html'
    OnHTMLTag = serverfunctionHTMLTag
    Left = 56
    Top = 160
  end
  object reversestring: TPageProducer
    HTMLFile = 'templates/reversestring.html'
    OnHTMLTag = serverfunctionHTMLTag
    Left = 56
    Top = 360
  end
  object filedispatcher: TWebFileDispatcher
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
    BeforeDispatch = filedispatcherBeforeDispatch
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
    Left = 56
    Top = 112
  end
  object proxygenerator: TDSProxyGenerator
    ExcludeClasses = 'DSMetadata'
    MetaDataProvider = dataprovider
    Writer = 'Java Script REST'
    Left = 56
    Top = 208
  end
  object dataprovider: TDSServerMetaDataProvider
    Server = dsserver
    Left = 56
    Top = 408
  end
end
