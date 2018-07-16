unit ufrm_srvmethod;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Json,
  System.JSON.Writers,
  System.JSON.Types,

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
  FireDAC.Stan.StorageJSON, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt;

type
  Tfrm_srvmethod = class(TDSServerModule)
    conn_db: TFDConnection;
    wait_cursor: TFDGUIxWaitCursor;
    driver_link: TFDPhysMySQLDriverLink;
    man_db: TFDManager;
    json_link: TFDStanStorageJSONLink;
    bin_link: TFDStanStorageBinLink;
    schema_adapter: TFDSchemaAdapter;
  private
    { Private declarations }
  public
    { Public declarations }
    function echostring(Value: string): string;
    function reversestring(Value: string): string;
    function user_signin(usr_username, usr_password: string): string;
  end;

  methods = class(Tfrm_srvmethod)

  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses System.StrUtils;

function Tfrm_srvmethod.user_signin(usr_username, usr_password: string): string;
var
  SQL           : string;
  qry           : TFDQuery;
  lResultado    : TJSONObject;
  lStringWriter : TStringWriter;
  lJSonWriter   : TJSonTextWriter;
begin
  SQL := 'set @po_valid_user = 0;' +
         'set @po_usr_cod    = 0;' +
         'call ccs.proc_user_signin('+ QuotedStr(usr_username) +', '+ QuotedStr(usr_password) +', @po_valid_user, @po_usr_cod);' +
         'select @po_valid_user as valid_user, @po_usr_cod as usr_cod;';

  qry := TFDQuery.Create(Self);

  qry.Close;
  qry.Connection := conn_db;
  qry.SQL.Add(SQL);
  qry.Prepare;
  qry.Open;

  if qry.FieldByName('valid_user').AsInteger = 1 then begin
    try
      try
        lStringWriter := TStringWriter.Create;
        lJSonWriter   := TJsonTextWriter.Create(lStringWriter);

        lJSonWriter.Formatting := TJsonFormatting.Indented;
        lJSonWriter.WriteStartObject;

        lJSonWriter.WritePropertyName('result');
        lJSonWriter.WriteValue('success');
        lJSonWriter.WritePropertyName('user_signin');
        lJSonWriter.WriteStartArray;

        while not (qry.Eof) do begin
          lJSonWriter.WriteStartObject;

          lJSonWriter.WritePropertyName('valid_user');
          lJSonWriter.WriteValue(qry.FieldByName('valid_user').AsString);
          lJSonWriter.WritePropertyName('usr_cod');
          lJSonWriter.WriteValue(qry.FieldByName('usr_cod').AsString);

          qry.Next;
          lJSonWriter.WriteEndObject;
        end;

        lJSonWriter.WriteEndArray;
        lJSonWriter.WriteEndObject;

        result := lStringWriter.ToString;

        GetInvocationMetadata().ResponseCode    := 200;
        GetInvocationMetadata().ResponseContent := Result;
      except on E: Exception do
      end;
    finally
    end;
  end else begin
    try
      try
        lResultado := TJSONObject.Create;

        lResultado.AddPair('result', 'error');

        result := lResultado.ToString;

        GetInvocationMetadata().ResponseCode    := 200;
        GetInvocationMetadata().ResponseContent := Result;
      except on E: Exception do
      end;
    finally
    end;
  end;
end;

function Tfrm_srvmethod.echostring(Value: string): string;
begin
  Result := Value;
end;

function Tfrm_srvmethod.reversestring(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

end.

