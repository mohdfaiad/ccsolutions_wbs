unit ufrm_webmodule;

interface

uses
  System.SysUtils,
  System.Classes,

  Web.HTTPApp,
  Web.WebFileDispatcher,
  Web.HTTPProd,
  Web.WebReq,

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
  DataSnap.DSAuth,

  ufrm_phonebook,
  ufrm_contract,
  ufrm_enterprise,
  ufrm_client,
  ufrm_contract_user,
  ufrm_login,
  ufrm_reseller, ufrm_product,
  ufrm_client_contract,
  ufrm_client_contract_iten,
  ufrm_voip_server,
  ufrm_client_astpp,
  ufrm_client_sippulse,
  ufrm_srvmethod,
  ufrm_print_astpp,
  ufrm_supplier,
  ufrm_ticket_type,
  ufrm_ticket_priority,
  ufrm_ticket_category,
  ufrm_ticket_category_sub,
  ufrm_material,
  ufrm_medicine,
  ufrm_insurance,
  ufrm_table_price,
  ufrm_did,
  ufrm_provider,
  ufrm_client_did,
  ufrm_proposal_contract,
  ufrm_proposal_contract_iten;

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
    phonebook: TDSServerClass;
    contract: TDSServerClass;
    enterprise: TDSServerClass;
    contract_user: TDSServerClass;
    client: TDSServerClass;
    login: TDSServerClass;
    reseller: TDSServerClass;
    product: TDSServerClass;
    client_contract: TDSServerClass;
    client_contract_iten: TDSServerClass;
    voip_server: TDSServerClass;
    client_astpp: TDSServerClass;
    client_sippulse: TDSServerClass;
    print_astpp: TDSServerClass;
    supplier: TDSServerClass;
    ticket_type: TDSServerClass;
    ticket_priority: TDSServerClass;
    ticket_category: TDSServerClass;
    ticket_category_sub: TDSServerClass;
    material: TDSServerClass;
    medicine: TDSServerClass;
    insurance: TDSServerClass;
    table_price: TDSServerClass;
    did: TDSServerClass;
    provider: TDSServerClass;
    client_did: TDSServerClass;
    proposal_contract: TDSServerClass;
    proposal_contract_iten: TDSServerClass;
    procedure dsserverclassGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure dsauthenticationUserAuthorize(Sender: TObject; EventObject: TDSAuthorizeEventObject; var valid: Boolean);
    procedure dsauthenticationUserAuthenticate(Sender: TObject; const Protocol, Context, User, Password: string; var valid: Boolean; UserRoles: TStrings);
    procedure serverfunctionHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure WebModuleDefaultAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleBeforeDispatch(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure webfileBeforeDispatch(Sender: TObject; const AFileName: string; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleCreate(Sender: TObject);
    procedure phonebookGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure contractGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure enterpriseGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure contract_userGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure clientGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure loginGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure resellerGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure productGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure client_contractGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure client_contract_itenGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure voip_serverGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure client_astppGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure client_sippulseGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure print_astppGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure supplierGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure ticket_typeGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure ticket_priorityGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure ticket_categoryGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure ticket_category_subGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure materialGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure medicineGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure insuranceGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure table_priceGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure didGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure providerGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure client_didGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure proposal_contractGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure proposal_contract_itenGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
  private
    FServerFunctionInvokerAction: TWebActionItem;
    function AllowServerFunctionInvoker: Boolean;

  public

  end;

var
  WebModuleClass: TComponentClass = Tfrm_webmodule;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure Tfrm_webmodule.clientGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_client.Client;
end;

procedure Tfrm_webmodule.client_astppGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_client_astpp.client_astpps;
end;

procedure Tfrm_webmodule.client_contractGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_client_contract.ClientContract;
end;

procedure Tfrm_webmodule.client_contract_itenGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_client_contract_iten.ClientContractIten;
end;

procedure Tfrm_webmodule.client_didGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_client_did.ClientDID;
end;

procedure Tfrm_webmodule.client_sippulseGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_client_sippulse.client_sippulses;
end;

procedure Tfrm_webmodule.contractGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_contract.contracts;
end;

procedure Tfrm_webmodule.contract_userGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_contract_user.contract_users;
end;

procedure Tfrm_webmodule.enterpriseGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_enterprise.enterprises;
end;

procedure Tfrm_webmodule.insuranceGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_insurance.Insurance;
end;

procedure Tfrm_webmodule.loginGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_login.login;
end;

procedure Tfrm_webmodule.materialGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_material.Material;
end;

procedure Tfrm_webmodule.medicineGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_medicine.Medicine;
end;

procedure Tfrm_webmodule.phonebookGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_phonebook.Phonebook;
end;

procedure Tfrm_webmodule.print_astppGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_print_astpp.print_astpps;
end;

procedure Tfrm_webmodule.productGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_product.Product;
end;

procedure Tfrm_webmodule.proposal_contractGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_proposal_contract.ProposalContract;
end;

procedure Tfrm_webmodule.proposal_contract_itenGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_proposal_contract_iten.ProposalContractIten
end;

procedure Tfrm_webmodule.providerGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_provider.Provider;
end;

procedure Tfrm_webmodule.resellerGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_reseller.Reseller;
end;

procedure Tfrm_webmodule.supplierGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_supplier.suppliers;
end;

procedure Tfrm_webmodule.table_priceGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_table_price.TablePrice;
end;

procedure Tfrm_webmodule.ticket_categoryGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_ticket_category.TicketCategory;
end;

procedure Tfrm_webmodule.ticket_category_subGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_ticket_category_sub.TicketCategorySub;
end;

procedure Tfrm_webmodule.ticket_priorityGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_ticket_priority.TicketPriority;
end;

procedure Tfrm_webmodule.ticket_typeGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_ticket_type.TicketType;
end;

procedure Tfrm_webmodule.voip_serverGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_voip_server.voip_servers;
end;

procedure Tfrm_webmodule.dsserverclassGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_srvmethod.methods;
end;

procedure Tfrm_webmodule.didGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ufrm_did.DID;
end;

procedure Tfrm_webmodule.dsauthenticationUserAuthenticate(Sender: TObject; const Protocol, Context, User, Password: string; var valid: Boolean; UserRoles: TStrings);
begin
  valid := True;
end;

procedure Tfrm_webmodule.dsauthenticationUserAuthorize(Sender: TObject; EventObject: TDSAuthorizeEventObject; var valid: Boolean);
begin
  valid := True;
end;

procedure Tfrm_webmodule.serverfunctionHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
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

procedure Tfrm_webmodule.WebModuleDefaultAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  if (Request.InternalPathInfo = '') or (Request.InternalPathInfo = '/')then
    Response.Content := ReverseString.Content
  else
    Response.SendRedirect(Request.InternalScriptName + '/');
end;

procedure Tfrm_webmodule.WebModuleBeforeDispatch(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  if FServerFunctionInvokerAction <> nil then
    FServerFunctionInvokerAction.Enabled := AllowServerFunctionInvoker;
end;

function Tfrm_webmodule.AllowServerFunctionInvoker: Boolean;
begin
  Result := (Request.RemoteAddr = '127.0.0.1') or
    (Request.RemoteAddr = '0:0:0:0:0:0:0:1') or (Request.RemoteAddr = '::1');
end;

procedure Tfrm_webmodule.webfileBeforeDispatch(Sender: TObject; const AFileName: string; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean); var
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

