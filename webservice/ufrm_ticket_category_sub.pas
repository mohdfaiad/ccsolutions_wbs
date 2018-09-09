unit ufrm_ticket_category_sub;

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

  ufrm_srvmethod;

type
{$METHODINFO ON}
  Tfrm_ticket_category_sub = class(TDataModule)
  private

  public
    //FUNCTION GET
    function TicketCategorySub (const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptTicketCategorySub : string;
    //FUNCTION POST
    function UpdateTicketCategorySub : string;
    //FUNCTION DELETE
    function CancelTicketCategorySub (const AToken, ACod: string): string;

  end;

  ticket_category_subs = class(Tfrm_ticket_category_sub)

  end;
{$METHODINFO OFF}

var
  frm_ticket_category_sub: Tfrm_ticket_category_sub;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_ticket_category_sub }

function Tfrm_ticket_category_sub.AcceptTicketCategorySub: string;
begin
  Result := 'PUT';
end;

function Tfrm_ticket_category_sub.CancelTicketCategorySub(const AToken,
  ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_ticket_category_sub.TicketCategorySub(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_ticket_category_sub_read('+ QuotedStr(AToken) +');';

  method  := Tfrm_srvmethod.Create(Self);
  qry     := TFDQuery.Create(Self);

  qry.Connection := method.conn_db;

  if not AToken.IsEmpty then begin
    qry.Open(SQL);
    Result := qry.DataSetToJSON;
  end else begin
    Result := TJSONArray.Create('Result', 'Data not found');
  end;

  GetInvocationMetadata().ResponseCode    := 200;
  GetInvocationMetadata().ResponseContent := Result.ToString;
end;

function Tfrm_ticket_category_sub.UpdateTicketCategorySub: string;
begin
  Result := 'POST';
end;

end.
