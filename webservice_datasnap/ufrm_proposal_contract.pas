unit ufrm_proposal_contract;

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
  Tfrm_proposal_contract = class(TDataModule)
  private

  public
    //FUNCTION GET
    function ProposalContracts(const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptProposalContracts: string;
    //FUNCTION POST
    function UpdateProposalContracts: string;
    //FUNCTION DELETE
    function CancelProposalContracts(const AToken, ACod: string): string;

  end;

  ProposalContract = class(Tfrm_proposal_contract)

  end;
{$METHODINFO OFF}
var
  frm_proposal_contract: Tfrm_proposal_contract;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_proposal_contract }

function Tfrm_proposal_contract.AcceptProposalContracts: string;
begin
  Result := 'PUT';
end;

function Tfrm_proposal_contract.CancelProposalContracts(const AToken, ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_proposal_contract.ProposalContracts(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_proposal_contract_read('+ QuotedStr(AToken) +');';

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

function Tfrm_proposal_contract.UpdateProposalContracts: string;
begin
  Result := 'POST';
end;

end.
