unit ufrm_insurance;

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
  Tfrm_insurance = class(TDataModule)
  private

  public
    //FUNCTION GET
    function Insurances (const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptInsurances : string;
    //FUNCTION POST
    function UpdateInsurances : string;
    //FUNCTION DELETE
    function CancelInsurances (const AToken, ACod: string): string;

  end;

  Insurance = class(Tfrm_Insurance)

  end;
{$METHODINFO OFF}

var
  frm_insurance: Tfrm_insurance;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_insurance }

function Tfrm_insurance.AcceptInsurances: string;
begin
  Result := 'PUT';
end;

function Tfrm_insurance.CancelInsurances(const AToken, ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_insurance.Insurances(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_insurance_read('+ QuotedStr(AToken) +');';

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

function Tfrm_insurance.UpdateInsurances: string;
begin
  Result := 'POST';
end;

end.
