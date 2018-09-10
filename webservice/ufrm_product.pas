unit ufrm_product;

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
  Tfrm_product = class(TDataModule)
  private

  public
    //FUNCTION GET
    function Product(const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptProduct: string;
    //FUNCTION POST
    function UpdateProduct: string;
    //FUNCTION DELETE
    function CancelProduct(const AToken, ACod: string): string;

  end;

  products = class(Tfrm_product)

  end;
{$METHODINFO OFF}

var
  frm_product: Tfrm_product;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_product }

function Tfrm_product.AcceptProduct: string;
begin
  Result := 'PUT';
end;

function Tfrm_product.CancelProduct(const AToken, ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_product.Product(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_product_read(' + QuotedStr(AToken) + ');';

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

function Tfrm_product.UpdateProduct: string;
begin
  Result := 'POST';
end;

end.
