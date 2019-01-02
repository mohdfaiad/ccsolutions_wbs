unit ufrm_supplier;

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
  Tfrm_supplier = class(TDataModule)
  private

  public
    //FUNCTION GET
    function Supplier (const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptSupplier : string;
    //FUNCTION POST
    function UpdateSupplier : string;
    //FUNCTION DELETE
    function CancelSupplier (const AToken, ACod: string): string;

  end;

  suppliers = class(Tfrm_supplier)

  end;
{$METHODINFO OFF}

var
  frm_supplier: Tfrm_supplier;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_supplier }

function Tfrm_supplier.AcceptSupplier: string;
begin
  Result := 'PUT';
end;

function Tfrm_supplier.CancelSupplier(const AToken, ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_supplier.Supplier(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_supplier_read('+ QuotedStr(AToken) +');';

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

function Tfrm_supplier.UpdateSupplier: string;
begin
  Result := 'POST';
end;

end.
