unit ufrm_contract;

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
  Tfrm_contract = class(TDataModule)
    private

    public
      //FUNCTION GET
      function Contracts (const AToken: string): TJSONArray;
      //FUNCTION PUT
      function AcceptContracts : string;
      //FUNCTION POST
      function UpdateContracts : string;
      //FUNCTION DELETE
      function CancelContracts (const AToken, ACod: string): string;

  end;

  Contract = class(Tfrm_contract)

  end;
{$METHODINFO OFF}

var
  frm_contract: Tfrm_contract;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_contract }

function Tfrm_contract.AcceptContracts: string;
begin
  Result := 'PUT';
end;

function Tfrm_contract.CancelContracts(const AToken, ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_contract.Contracts(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_contract_read('+ QuotedStr(AToken) +');';

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

function Tfrm_contract.UpdateContracts: string;
begin
  Result := 'POST';
end;

end.
