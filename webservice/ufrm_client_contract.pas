unit ufrm_client_contract;

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

  ufrm_srvmethod, FireDAC.Stan.Option;

type
{$METHODINFO ON}
  Tfrm_client_contract = class(TDataModule)
  private

  public
    //FUNCTION GET
    function ClientContract(const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptClientContract: string;
    //FUNCTION POST
    function UpdateClientContract: string;
    //FUNCTION DELETE
    function CancelClientContract(const AToken, ACod: string): string;

  end;

  client_contracts = class(Tfrm_client_contract)

  end;
{$METHODINFO OFF}

var
  frm_client_contract: Tfrm_client_contract;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_client_contract }

function Tfrm_client_contract.AcceptClientContract: string;
begin
  Result := 'PUT';
end;

function Tfrm_client_contract.CancelClientContract(const AToken, ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_client_contract.ClientContract(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_client_contract_read(' + QuotedStr(AToken) + ');';

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

function Tfrm_client_contract.UpdateClientContract: string;
begin
  Result := 'POST';
end;

end.
