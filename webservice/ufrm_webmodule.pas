unit ufrm_webmodule;

interface

uses
  System.SysUtils,
  System.Classes,

  Web.HTTPApp,
  Web.WebFileDispatcher,
  Web.HTTPProd,

  IPPeerServer,

  Datasnap.DSHTTPCommon,
  Datasnap.DSHTTPWebBroker,
  Datasnap.DSServer,
  Datasnap.DSMetadata,
  Datasnap.DSServerMetadata,
  Datasnap.DSClientMetadata,
  Datasnap.DSCommonServer,
  Datasnap.DSProxyJavaScript,
  Datasnap.DSHTTP,
  DataSnap.DSAuth, ufrm_phonebook, ufrm_contract, ufrm_enterprise, ufrm_client,
  ufrm_contract_user, ufrm_login, ufrm_reseller, ufrm_product;

type
  Tfrm_webmodule = class(TWebModule)
    dshttpweb: TDSHTTPWebDispatcher;
    dsserver: TDSServer;
    dsauthentication: TDSAuthenticationManager;
    dsserverclass: TDSServerClass;
    serverfunction: TPageProducer;
    reversestring: TPageProducer;
    webfile: TWebFileDispatcher;
    dsproxygenerator: TDSProxyGenerator;
    dsserverprovider: TDSServerMetaDataProvider;
    dssc_phonebook: TDSServerClass;
    dssc_contract: TDSServerClass;
    dssc_enterprise: TDSServerClass;
    dssc_contract_user: TDSServerClass;
    dssc_client: TDSServerClass;
    dssc_login: TDSServerClass;
    dssc_reseller: TDSServerClass;
    dssc_product: TDSServerClass;
    procedure dsserverclassGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dsauthenticationUserAuthorize(Sender: TObject;
      EventObject: TDSAuthorizeEventObject; var valid: Boolean);
    procedure dsauthenticationUserAuthenticate(Sender: TObject;
      const Protocol, Context, User, Password: string; var valid: Boolean;
      UserRoles: TStrings);
    procedure serverfunctionHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure WebModuleDefaultAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleBeforeDispatch(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure webfileBeforeDispatch(Sender: TObject;
      const AFileName: string; Request: TWebRequest; Response: TWebResponse;
      var Handled: Boolean);
    procedure WebModuleCreate(Sender: TObject);
    procedure dssc_phonebookGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dssc_contractGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dssc_enterpriseGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dssc_contract_userGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dssc_clientGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dssc_loginGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dssc_resellerGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure dssc_productGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
  private
    { Private declarations }
    FServerFunctionInvokerAction: TWebActionItem;
    function AllowServerFunctionInvoker: Boolean;
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = Tfrm_webmodule;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses ufrm_srvmethod, Web.WebReq;

procedure Tfrm_webmodule.dssc_clientGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_client.clients;
end;

procedure Tfrm_webmodule.dssc_contractGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_contract.contracts;
end;

procedure Tfrm_webmodule.dssc_contract_userGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_contract_user.contract_users;
end;

procedure Tfrm_webmodule.dssc_enterpriseGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_enterprise.enterprises;
end;

procedure Tfrm_webmodule.dssc_loginGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_login.login;
end;

procedure Tfrm_webmodule.dssc_phonebookGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_phonebook.phonebooks;
end;

procedure Tfrm_webmodule.dssc_productGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_product.products;
end;

procedure Tfrm_webmodule.dssc_resellerGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_reseller.resellers;
end;

procedure Tfrm_webmodule.dsserverclassGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_srvmethod.methods;
end;

procedure Tfrm_webmodule.dsauthenticationUserAuthenticate(
  Sender: TObject; const Protocol, Context, User, Password: string;
  var valid: Boolean; UserRoles: TStrings);
begin
  valid := True;
end;

procedure Tfrm_webmodule.dsauthenticationUserAuthorize(
  Sender: TObject; EventObject: TDSAuthorizeEventObject; 
  var valid: Boolean);
begin
  valid := True;
end;

procedure Tfrm_webmodule.serverfunctionHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  if SameText(TagString, 'urlpath') then
    ReplaceText := string(Request.InternalScriptName)
  else if SameText(TagString, 'port') then
    ReplaceText := IntToStr(Request.ServerPort)
  else if SameText(TagString, 'host') then
    ReplaceText := string(Request.Host)
  else if SameText(TagString, 'classname') then
    ReplaceText := ufrm_srvmethod.Tfrm_srvmethod.ClassName
  else if SameText(TagString, 'loginrequired') then
    if dshttpweb.AuthenticationManager <> nil then
      ReplaceText := 'true'
    else
      ReplaceText := 'false'
  else if SameText(TagString, 'serverfunctionsjs') then
    ReplaceText := string(Request.InternalScriptName) + '/js/serverfunctions.js'
  else if SameText(TagString, 'servertime') then
    ReplaceText := DateTimeToStr(Now)
  else if SameText(TagString, 'serverfunctioninvoker') then
    if AllowServerFunctionInvoker then
      ReplaceText :=
      '<div><a href="' + string(Request.InternalScriptName) +
      '/ServerFunctionInvoker" target="_blank">Server Functions</a></div>'
    else
      ReplaceText := '';
end;

procedure Tfrm_webmodule.WebModuleDefaultAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  if (Request.InternalPathInfo = '') or (Request.InternalPathInfo = '/')then
    Response.Content := ReverseString.Content
  else
    Response.SendRedirect(Request.InternalScriptName + '/');
end;

procedure Tfrm_webmodule.WebModuleBeforeDispatch(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  if FServerFunctionInvokerAction <> nil then
    FServerFunctionInvokerAction.Enabled := AllowServerFunctionInvoker;
end;

function Tfrm_webmodule.AllowServerFunctionInvoker: Boolean;
begin
  Result := (Request.RemoteAddr = '127.0.0.1') or
    (Request.RemoteAddr = '0:0:0:0:0:0:0:1') or (Request.RemoteAddr = '::1');
end;

procedure Tfrm_webmodule.webfileBeforeDispatch(Sender: TObject;
  const AFileName: string; Request: TWebRequest; Response: TWebResponse;
  var Handled: Boolean);
var
  D1, D2: TDateTime;
begin
  Handled := False;
  if SameFileName(ExtractFileName(AFileName), 'serverfunctions.js') then
    if not FileExists(AFileName) or (FileAge(AFileName, D1) and FileAge(WebApplicationFileName, D2) and (D1 < D2)) then
    begin
      dsproxygenerator.TargetDirectory := ExtractFilePath(AFileName);
      dsproxygenerator.TargetUnitName := ExtractFileName(AFileName);
      dsproxygenerator.Write;
    end;
end;

procedure Tfrm_webmodule.WebModuleCreate(Sender: TObject);
begin
  FServerFunctionInvokerAction := ActionByName('ServerFunctionInvokerAction');
end;

initialization
finalization
  Web.WebReq.FreeWebModules;

end.

