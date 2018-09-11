unit ufrm_table_price;

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
  Tfrm_table_price = class(TDataModule)
  private

  public
    //FUNCTION GET
    function TablePrices(const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptTablePrices: string;
    //FUNCTION POST
    function UpdateTablePrices: string;
    //FUNCTION DELETE
    function CancelTablePrices(const AToken, ACod: string): string;

  end;

  TablePrice = class(Tfrm_table_price)

  end;
{$METHODINFO OFF}

var
  frm_table_price: Tfrm_table_price;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_table_price }

function Tfrm_table_price.AcceptTablePrices: string;
begin
  Result := 'PUT';
end;

function Tfrm_table_price.CancelTablePrices(const AToken, ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_table_price.TablePrices(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_table_price_read('+ QuotedStr(AToken) +');';

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

function Tfrm_table_price.UpdateTablePrices: string;
begin
  Result := 'POST';
end;

end.
