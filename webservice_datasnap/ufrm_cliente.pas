unit ufrm_cliente;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON.Writers,
  System.JSON.Types,
  System.JSON.Readers,
  System.JSON,

  FireDAC.Comp.Client,
  FireDAC.Stan.Option,

  Data.DB,
  Data.DBXPlatform,

  u_ds_classhelper,

  ufrm_srvmethod, Web.HTTPApp;

type
{$METHODINFO ON}
  Tfrm_cliente = class(TDataModule)
  private

  public
    //FUNCTION GET
    function Clientes(const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptClientes: string;
    //FUNCTION POST
    function UpdateClientes: TJSONArray;
    //FUNCTION DELETE
    function CancelClientes(const AToken, ACod: string): string;

  end;

  Cliente = class(Tfrm_cliente)

  end;
{$METHODINFO OFF}

var
  frm_cliente: Tfrm_cliente;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_client }

function Tfrm_cliente.AcceptClientes: string;
begin
  Result := 'PUT';
end;

function Tfrm_cliente.CancelClientes(const AToken, ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_cliente.Clientes(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_cliente_read('+ QuotedStr(AToken) +');';

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

function Tfrm_cliente.UpdateClientes: TJSONArray;
begin
//
end;

end.
