unit ufrm_print_astpp;

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
  Tfrm_print_astpp = class(TDataModule)
  private

  public
    //FUNCTION GET
    function PrintASTPP(const AToken, AClient, ADateStart, ADateEnd: string): TJSONArray;
    //FUNCTION PUT
    function AcceptPrintASTPP: string;
    //FUNCTION POST
    function UpdatePrintASTPP: string;
    //FUNCTION DELETE
    function CancelPrintASTPP(const AToken, ACod: string): string;

  end;

  print_astpps = class(Tfrm_print_astpp)

  end;
{$METHODINFO OFF}
var
  frm_print_astpp: Tfrm_print_astpp;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_print_astpp }

function Tfrm_print_astpp.AcceptPrintASTPP: string;
begin
  Result := 'PUT';
end;

function Tfrm_print_astpp.CancelPrintASTPP(const AToken, ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_print_astpp.PrintASTPP(const AToken, AClient, ADateStart, ADateEnd: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_import_call_log_astpp_read('+ QuotedStr(AToken) +', '+ QuotedStr(AClient)+', '+ QuotedStr(ADateStart)+', '+ QuotedStr(ADateEnd)+');';

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

function Tfrm_print_astpp.UpdatePrintASTPP: string;
begin
  Result := 'POST';
end;

end.
