unit ufrm_proposal_contract_iten;

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
  Tfrm_proposal_contract_iten = class(TDataModule)
  private

  public
    //FUNCTION GET
    function ProposalContractItens(const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptProposalContractItens: string;
    //FUNCTION POST
    function UpdateProposalContractItens: string;
    //FUNCTION DELETE
    function CancelProposalContractItens(const AToken, ACod: string): string;

  end;

  ProposalContractIten = class(Tfrm_proposal_contract_iten)

  end;
{$METHODINFO OFF}

var
  frm_proposal_contract_iten: Tfrm_proposal_contract_iten;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_proposal_contract_iten }

function Tfrm_proposal_contract_iten.AcceptProposalContractItens: string;
begin
  Result := 'PUT';
end;

function Tfrm_proposal_contract_iten.CancelProposalContractItens(const AToken, ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_proposal_contract_iten.ProposalContractItens(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_proposal_contract_iten_read('+ QuotedStr(AToken) +');';

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

function Tfrm_proposal_contract_iten.UpdateProposalContractItens: string;
begin
  Result := 'POST';
end;

end.
