unit ufrm_ticket;

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
  Tfrm_ticket = class(TDataModule)
  private

  public
    //FUNCTION GET
    function Tickets (const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptTickets : string;
    //FUNCTION POST
    function UpdateTickets : string;
    //FUNCTION DELETE
    function CancelTickets (const AToken, ACod: string): string;

  end;

  Ticket = class(Tfrm_ticket)

  end;
{$METHODINFO OFF}

var
  frm_ticket: Tfrm_ticket;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_ticket }

function Tfrm_ticket.AcceptTickets: string;
begin
  Result := 'PUT';
end;

function Tfrm_ticket.CancelTickets(const AToken, ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_ticket.Tickets(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_ticket_read('+ QuotedStr(AToken) +');';

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

function Tfrm_ticket.UpdateTickets: string;
begin
  Result := 'POST';
end;

end.
