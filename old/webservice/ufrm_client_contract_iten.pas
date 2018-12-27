unit ufrm_client_contract_iten;

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
  Tfrm_client_contract_iten = class(TDataModule)
  private

  public
    //FUNCTION GET
    function ClientContractItens(const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptClientContractItens: string;
    //FUNCTION POST
    function UpdateClientContractItens: string;
    //FUNCTION DELETE
    function CancelClientContractItens(const AToken, ACod: string): string;

  end;

  ClientContractIten = class(Tfrm_client_contract_iten)

  end;
{$METHODINFO OFF}

var
  frm_client_contract_iten: Tfrm_client_contract_iten;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_client_contract_iten }

function Tfrm_client_contract_iten.AcceptClientContractItens: string;
begin
  Result := 'PUT';
end;

function Tfrm_client_contract_iten.CancelClientContractItens(const AToken, ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_client_contract_iten.ClientContractItens(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_client_contract_iten_read('+ QuotedStr(AToken) +')';

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

function Tfrm_client_contract_iten.UpdateClientContractItens: string;
begin
  Result := 'POST';
end;

end.
