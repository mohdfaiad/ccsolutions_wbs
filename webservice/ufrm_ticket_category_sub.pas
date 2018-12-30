unit ufrm_ticket_category_sub;

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
  Tfrm_ticket_category_sub = class(TDataModule)
  private

  public
    //FUNCTION GET
    function TicketCategorySubs (const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptTicketCategorySubs : string;
    //FUNCTION POST
    function UpdateTicketCategorySubs : string;
    //FUNCTION DELETE
    function CancelTicketCategorySubs (const AToken, ACod: string): string;

  end;

  TicketCategorySub = class(Tfrm_ticket_category_sub)

  end;
{$METHODINFO OFF}

var
  frm_ticket_category_sub: Tfrm_ticket_category_sub;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_ticket_category_sub }

function Tfrm_ticket_category_sub.AcceptTicketCategorySubs: string;
begin
  Result := 'PUT';
end;

function Tfrm_ticket_category_sub.CancelTicketCategorySubs(const AToken,
  ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_ticket_category_sub.TicketCategorySubs(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_ticket_category_sub_read('+ QuotedStr(AToken) +');';

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

function Tfrm_ticket_category_sub.UpdateTicketCategorySubs: string;
begin
  Result := 'POST';
end;

end.
