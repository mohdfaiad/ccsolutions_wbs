unit ufrm_provider;

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
  Tfrm_provider = class(TDataModule)
  private

  public
    //FUNCTION GET
    function Providers(const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptProviders: string;
    //FUNCTION POST
    function UpdateProviders: string;
    //FUNCTION DELETE
    function CancelProviders(const AToken, ACod: string): string;

  end;

  Provider = class(Tfrm_provider)

  end;
{$METHODINFO OFF}

var
  frm_provider: Tfrm_provider;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_provider }

function Tfrm_provider.AcceptProviders: string;
begin
  Result := 'PUT';
end;

function Tfrm_provider.CancelProviders(const AToken, ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_provider.Providers(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_provider_read('+ QuotedStr(AToken) +');';

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

function Tfrm_provider.UpdateProviders: string;
begin
  Result := 'POST';
end;

end.
