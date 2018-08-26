unit ufrm_reseller;

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
  Tfrm_reseller = class(TDataModule)
  private

  public
    //FUNCTION GET
    function Reseller(const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptPhonebook : string;
    //FUNCTION POST
    function UpdatePhonebook : string;
    //FUNCTION DELETE
    function CancelPhonebook(const AToken, ACod: string): string;

  end;

  resellers = class(Tfrm_reseller)

  end;
{$METHODINFO OFF}

var
  frm_reseller: Tfrm_reseller;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_reseller }

function Tfrm_reseller.AcceptPhonebook: string;
begin
  Result := 'PUT';
end;

function Tfrm_reseller.CancelPhonebook(const AToken, ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_reseller.Reseller(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_reseller_read('+ QuotedStr(AToken) +');';
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

function Tfrm_reseller.UpdatePhonebook: string;
begin
  Result := 'POST';
end;

end.
