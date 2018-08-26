unit ufrm_srvmethod;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Json,
  System.JSON.Writers,
  System.JSON.Types,
  System.StrUtils,

  DataSnap.DSProviderDataModuleAdapter,
  Datasnap.DSServer,
  Datasnap.DSAuth,

  Data.DB,
  Data.DBXPlatform,

  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.ConsoleUI.Wait,
  FireDAC.Phys.MySQLDef,
  FireDAC.Phys.MySQL,
  FireDAC.Comp.UI,
  FireDAC.Comp.Client,
  FireDAC.Stan.StorageBin,
  FireDAC.Stan.StorageJSON,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,

  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP,
  IdURI,

  u_ds_classhelper;

type
  Tfrm_srvmethod = class(TDSServerModule)
    conn_db         : TFDConnection;
    wait_cursor     : TFDGUIxWaitCursor;
    driver_link     : TFDPhysMySQLDriverLink;
    man_db          : TFDManager;
    json_link       : TFDStanStorageJSONLink;
    bin_link        : TFDStanStorageBinLink;
    schema_adapter  : TFDSchemaAdapter;
  private

  public
    function echostring(Value: string): string;
    function reversestring(Value: string): string;
    function send_sms(address, username, password, phone, text: string) : string;

  end;

  methods = class(Tfrm_srvmethod)

  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

function Tfrm_srvmethod.echostring(Value: string): string;
begin
  Result := Value;
end;

function Tfrm_srvmethod.reversestring(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

function Tfrm_srvmethod.send_sms(address, username, password, phone, text: string): string;
var
  lURL, lURLEnconde : string;
  lHTTP             : TIdHTTP;
begin
  lURL  := 'http://'+address + '/default/en_US/send.html?u='+ username +'&p='+ password +'&l=1&n='+ phone +'&m='+ text;

  lHTTP := TIdHTTP.Create(Self);

  try
    try
      lURLEnconde := TIdURI.URLEncode(lURL);

      Result := lHTTP.Get(lURLEnconde);

      GetInvocationMetadata().ResponseCode    := 200;
      GetInvocationMetadata().ResponseContent := Result;
    except on E: Exception do
    end;
  finally
    lHTTP.Free;
  end;
end;

end.

