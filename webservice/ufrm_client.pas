unit ufrm_client;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON.Writers,
  System.JSON.Types,
  System.JSON,

  FireDAC.Comp.Client,

  Data.DB,
  Data.DBXPlatform,

  u_ds_classhelper,

  ufrm_srvmethod;

type
{$METHODINFO ON}
  Tfrm_client = class(TDataModule)
  private

  public
    //FUNCTION GET
    function Client(const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptClient: string;
    //FUNCTION POST
    function UpdateClient: string;
    //FUNCTION DELETE
    function CancelClient(const AToken, ACod: string): string;

  end;

  clients = class(Tfrm_client)

  end;
{$METHODINFO OFF}

var
  frm_client: Tfrm_client;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}
{$R *.dfm}
{ Tfrm_client }

function Tfrm_client.AcceptClient: string;
begin
  Result := 'PUT';
end;

function Tfrm_client.CancelClient(const AToken, ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_client.Client(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_client_read(' + QuotedStr(AToken) + ');';

  method  := Tfrm_srvmethod.Create(Self);
  qry     := TFDQuery.Create(Self);

  qry.Connection := method.conn_db;

  if not AToken.IsEmpty then begin
    qry.Open(SQL);
    Result := qry.DataSetToJSON;
  end else begin
    Result := TJSONArray.Create('Result', 'Data not found');
  end;

  GetInvocationMetadata().ResponseCode    := 200;
  GetInvocationMetadata().ResponseContent := Result.ToString;
end;

function Tfrm_client.UpdateClient: string;
begin
  Result := 'POST';
end;

end.
