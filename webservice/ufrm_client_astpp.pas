unit ufrm_client_astpp;

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
  Tfrm_client_astpp = class(TDataModule)
  private

  public
    //FUNCTION GET
    function ClientASTPP(const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptClientASTPP: string;
    //FUNCTION POST
    function UpdateClientASTPP: string;
    //FUNCTION DELETE
    function CancelClientASTPP(const AToken, ACod: string): string;

  end;

  client_astpps = class(Tfrm_client_astpp)

  end;
{$METHODINFO OFF}

var
  frm_client_astpp: Tfrm_client_astpp;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_client_astpp }

function Tfrm_client_astpp.AcceptClientASTPP: string;
begin
  Result := 'PUT';
end;

function Tfrm_client_astpp.CancelClientASTPP(const AToken,
  ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_client_astpp.ClientASTPP(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_client_astpp_read('+ QuotedStr(AToken) +');';

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

function Tfrm_client_astpp.UpdateClientASTPP: string;
begin
  Result := 'POST';
end;

end.
