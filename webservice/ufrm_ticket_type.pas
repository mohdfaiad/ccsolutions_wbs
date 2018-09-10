unit ufrm_ticket_type;

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
  Tfrm_ticket_type = class(TDataModule)
  private

  public
    //FUNCTION GET
    function TicketType (const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptTicketType : string;
    //FUNCTION POST
    function UpdateTicketType : string;
    //FUNCTION DELETE
    function CancelTicketType (const AToken, ACod: string): string;

  end;

  ticket_types = class(Tfrm_ticket_type)

  end;
{$METHODINFO OFF}

var
  frm_ticket_type: Tfrm_ticket_type;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_ticket_type }

function Tfrm_ticket_type.AcceptTicketType: string;
begin
  Result := 'PUT';
end;

function Tfrm_ticket_type.CancelTicketType(const AToken, ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_ticket_type.TicketType(const AToken: string): TJSONArray;
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

function Tfrm_ticket_type.UpdateTicketType: string;
begin
  Result := 'POST';
end;

end.
