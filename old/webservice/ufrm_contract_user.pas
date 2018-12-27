unit ufrm_contract_user;

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
  Tfrm_contract_user = class(TDataModule)
  private

  public
    //FUNCTION GET
    function ContractUsers (const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptContractUsers : string;
    //FUNCTION POST
    function UpdateContractUsers : string;
    //FUNCTION DELETE
    function CancelContractUsers (const AToken, ACod: string): string;

  end;

  ContractUser = class(Tfrm_contract_user)

  end;
{$METHODINFO OFF}

var
  frm_contract_user: Tfrm_contract_user;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_contract_user }

function Tfrm_contract_user.AcceptContractUsers: string;
begin
  Result := 'PUT';
end;

function Tfrm_contract_user.CancelContractUsers(const AToken, ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_contract_user.ContractUsers(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_contract_user_read('+ QuotedStr(AToken) +');';

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

function Tfrm_contract_user.UpdateContractUsers: string;
begin
  Result := 'POST';
end;

end.
