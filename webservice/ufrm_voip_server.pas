unit ufrm_voip_server;

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
  Tfrm_voip_server = class(TDataModule)
  private

  public
    //FUNCTION GET
    function VoipServer(const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptVoipServer: string;
    //FUNCTION POST
    function UpdateVoipServer: string;
    //FUNCTION DELETE
    function CancelVoipServer(const AToken, ACod: string): string;

  end;

  voip_servers = class(Tfrm_voip_server)

  end;
{$METHODINFO OFF}

var
  frm_voip_server: Tfrm_voip_server;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_voip_server }

function Tfrm_voip_server.AcceptVoipServer: string;
begin
  Result := 'PUT';
end;

function Tfrm_voip_server.CancelVoipServer(const AToken, ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_voip_server.VoipServer(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_voip_server_read(' + QuotedStr(AToken) + ');';

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

function Tfrm_voip_server.UpdateVoipServer: string;
begin
  Result := 'POST';
end;

end.
