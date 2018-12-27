unit ufrm_ticket_category;

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
  Tfrm_ticket_category = class(TDataModule)
  private

  public
    //FUNCTION GET
    function TicketCategorys (const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptTicketCategorys : string;
    //FUNCTION POST
    function UpdateTicketCategorys : string;
    //FUNCTION DELETE
    function CancelTicketCategorys (const AToken, ACod: string): string;

  end;

  TicketCategory = class(Tfrm_ticket_category)

  end;
{$METHODINFO OFF}

var
  frm_ticket_category: Tfrm_ticket_category;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_ticket_category }

function Tfrm_ticket_category.AcceptTicketCategorys: string;
begin
  Result := 'PUT';
end;

function Tfrm_ticket_category.CancelTicketCategorys(const AToken,
  ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_ticket_category.TicketCategorys(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_ticket_category_read('+ QuotedStr(AToken) +');';

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

function Tfrm_ticket_category.UpdateTicketCategorys: string;
begin
  Result := 'POST';
end;

end.
