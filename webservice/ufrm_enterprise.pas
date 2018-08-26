unit ufrm_enterprise;

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
  Tfrm_enterprise = class(TDataModule)
  private

  public
    //FUNCTION GET
    function Enterprise (const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptEnterprise : string;
    //FUNCTION POST
    function UpdateEnterprise : string;
    //FUNCTION DELETE
    function CancelEnterprise (const AToken, ACod: string): string;

  end;

  enterprises = class(Tfrm_enterprise)

  end;
{$METHODINFO OFF}

var
  frm_enterprise: Tfrm_enterprise;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_enterprise }

function Tfrm_enterprise.AcceptEnterprise: string;
begin
  Result := 'PUT';
end;

function Tfrm_enterprise.CancelEnterprise(const AToken, ACod: string): string;
begin
    Result := 'DELETE';
end;

function Tfrm_enterprise.Enterprise(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_enterprise_read('+ QuotedStr(AToken) +');';

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

function Tfrm_enterprise.UpdateEnterprise: string;
begin
  Result := 'POST';
end;

end.
