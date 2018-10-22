unit ufrm_ticket_type;

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
  Tfrm_ticket_type = class(TDataModule)
  private

  public
    //FUNCTION GET
    function TicketTypes (const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptTicketTypes : string;
    //FUNCTION POST
    function UpdateTicketTypes : string;
    //FUNCTION DELETE
    function CancelTicketTypes (const AToken, ACod: string): string;

  end;

  TicketType = class(Tfrm_ticket_type)

  end;
{$METHODINFO OFF}

var
  frm_ticket_type: Tfrm_ticket_type;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_ticket_type }

function Tfrm_ticket_type.AcceptTicketTypes: string;
begin
  Result := 'PUT';
end;

function Tfrm_ticket_type.CancelTicketTypes(const AToken, ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_ticket_type.TicketTypes(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_ticket_type_read('+ QuotedStr(AToken) +');';

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

function Tfrm_ticket_type.UpdateTicketTypes: string;
begin
  Result := 'POST';
end;

end.
