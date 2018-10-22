unit ufrm_ticket_priority;

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
  Tfrm_ticket_priority = class(TDataModule)
  private

  public
    //FUNCTION GET
    function TicketPrioritys (const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptTicketPrioritys : string;
    //FUNCTION POST
    function UpdateTicketPrioritys : string;
    //FUNCTION DELETE
    function CancelTicketPrioritys (const AToken, ACod: string): string;

  end;

  TicketPriority = class(Tfrm_ticket_priority)

  end;
{$METHODINFO OFF}

var
  frm_ticket_priority: Tfrm_ticket_priority;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_ticket_priority }

function Tfrm_ticket_priority.AcceptTicketPrioritys: string;
begin
  Result := 'PUT';
end;

function Tfrm_ticket_priority.CancelTicketPrioritys(const AToken,
  ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_ticket_priority.TicketPrioritys(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_ticket_priority_read('+ QuotedStr(AToken) +');';

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

function Tfrm_ticket_priority.UpdateTicketPrioritys: string;
begin
  Result := 'POST';
end;

end.
