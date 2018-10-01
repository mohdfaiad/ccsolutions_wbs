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

  ufrm_srvmethod, FireDAC.Stan.Option;

type
{$METHODINFO ON}
  Tfrm_reseller = class(TDataModule)
  private

  public
    //FUNCTION GET
    function Resellers(const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptResellers : string;
    //FUNCTION POST
    function UpdateResellers : string;
    //FUNCTION DELETE
    function CancelResellers(const AToken, ACod: string): string;

  end;

  Reseller = class(Tfrm_reseller)

  end;
{$METHODINFO OFF}

var
  frm_reseller: Tfrm_reseller;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_reseller }

function Tfrm_reseller.AcceptResellers: string;
begin
  Result := 'PUT';
end;

function Tfrm_reseller.CancelResellers(const AToken, ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_reseller.Resellers(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_reseller_read('+ QuotedStr(AToken) +');';
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

function Tfrm_reseller.UpdateResellers: string;
begin
  Result := 'POST';
end;

end.
