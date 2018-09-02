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

  ufrm_srvmethod;

type
{$METHODINFO ON}
  Tfrm_client_contract_iten = class(TDataModule)
  private

  public
    //FUNCTION GET
    function ClientContractIten(const AToken, AClientContract: string): TJSONArray;
    //FUNCTION PUT
    function AcceptClientContractIten: string;
    //FUNCTION POST
    function UpdateClientContractIten: string;
    //FUNCTION DELETE
    function CancelClientContractIten(const AToken, ACod: string): string;

  end;

  client_contract_itens = class(Tfrm_client_contract_iten)

  end;
{$METHODINFO OFF}

var
  frm_client_contract_iten: Tfrm_client_contract_iten;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_client_contract_iten }

function Tfrm_client_contract_iten.AcceptClientContractIten: string;
begin
  Result := 'PUT';
end;

function Tfrm_client_contract_iten.CancelClientContractIten(const AToken, ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_client_contract_iten.ClientContractIten(const AToken, AClientContract: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_client_contract_iten_read('+ QuotedStr(AToken) +', '+ QuotedStr(AClientContract) +')';

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

function Tfrm_client_contract_iten.UpdateClientContractIten: string;
begin
  Result := 'POST';
end;

end.
