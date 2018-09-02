unit ufrm_client_sippulse;

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
  Tfrm_client_sippulse = class(TDataModule)
  private

  public
    //FUNCTION GET
    function ClientSIPPulse(const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptClientSIPPulse: string;
    //FUNCTION POST
    function UpdateClientSIPPulse: string;
    //FUNCTION DELETE
    function CancelClientSIPPulse(const AToken, ACod: string): string;

  end;

  client_sippulses = class(Tfrm_client_sippulse)

  end;
{$METHODINFO OFF}

var
  frm_client_sippulse: Tfrm_client_sippulse;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_client_sippulse }

function Tfrm_client_sippulse.AcceptClientSIPPulse: string;
begin
  Result := 'PUT';
end;

function Tfrm_client_sippulse.CancelClientSIPPulse(const AToken, ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_client_sippulse.ClientSIPPulse(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_client_sippulse_read('+ QuotedStr(AToken) +');';

  method  := Tfrm_srvmethod.Create(Self);
  qry     := TFDQuery.Create(Self);

  qry.Connection := method.conn_db;

  if not AToken.IsEmpty then begin
    qry.Open(SQL);
    Result := qry.DataSetToJSON;
  end else begin
    Result := TJSONArray.Create('Result', 'False');
  end;

  GetInvocationMetadata().ResponseCode    := 200;
  GetInvocationMetadata().ResponseContent := Result.ToString;
end;

function Tfrm_client_sippulse.UpdateClientSIPPulse: string;
begin
  Result := 'POST';
end;

end.
