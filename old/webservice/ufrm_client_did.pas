unit ufrm_client_did;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON.Writers,
  System.JSON.Types,
  System.JSON,

  FireDAC.Comp.Client,
  FireDAC.Stan.Option,

  Data.DB,
  Data.DBXPlatform,

  u_ds_classhelper,

  ufrm_srvmethod;

type
{$METHODINFO ON}
  Tfrm_client_did = class(TDataModule)
  private

  public
    //FUNCTION GET
    function ClientDIDs (const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptClientDIDs : string;
    //FUNCTION POST
    function UpdateClientDIDs : string;
    //FUNCTION DELETE
    function CancelClientDIDs (const AToken, ACod: string): string;

  end;

  ClientDID = class(Tfrm_client_did)

  end;
{$METHODINFO OFF}

var
  frm_client_did: Tfrm_client_did;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_client_did }

function Tfrm_client_did.AcceptClientDIDs: string;
begin
  Result := 'PUT';
end;

function Tfrm_client_did.CancelClientDIDs(const AToken, ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_client_did.ClientDIDs(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_client_did_read('+ QuotedStr(AToken) +');';

  method  := Tfrm_srvmethod.Create(Self);
  qry     := TFDQuery.Create(Self);

  qry.Connection := method.conn_db;
  qry.FetchOptions.Mode := TFDFetchMode.fmAll;
  qry.Open(SQL);

  if not (qry.IsEmpty) then begin
    Result := qry.DataSetToJSON;
  end else begin
    Result := qry.DataSetToJSON;
  end;

  GetInvocationMetadata().ResponseCode    := 200;
  GetInvocationMetadata().ResponseContent := Result.ToString;
end;

function Tfrm_client_did.UpdateClientDIDs: string;
begin
  Result := 'POST';
end;

end.
