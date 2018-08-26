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

  ufrm_srvmethod;

type
{$METHODINFO ON}
  Tfrm_contract = class(TDataModule)
    private

    public
      //FUNCTION GET
      function Contract (const AToken: string): TJSONArray;
      //FUNCTION PUT
      function AcceptContract : string;
      //FUNCTION POST
      function UpdateContract : string;
      //FUNCTION DELETE
      function CancelContract (const AToken, ACod: string): string;

  end;

  contracts = class(Tfrm_contract)

  end;
{$METHODINFO OFF}

var
  frm_contract: Tfrm_contract;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_contract }

function Tfrm_contract.AcceptContract: string;
begin
  Result := 'PUT';
end;

function Tfrm_contract.CancelContract(const AToken, ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_contract.Contract(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_contract_read('+ QuotedStr(AToken) +');';

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

function Tfrm_contract.UpdateContract: string;
begin
  Result := 'POST';
end;

end.
