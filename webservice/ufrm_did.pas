unit ufrm_did;

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
  Tfrm_did = class(TDataModule)
  private

  public
    //FUNCTION GET
    function DIDs(const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptDIDs: string;
    //FUNCTION POST
    function UpdateDIDs: string;
    //FUNCTION DELETE
    function CancelDIDs(const AToken, ACod: string): string;

  end;

  DID = class(Tfrm_did)

  end;
{$METHODINFO OFF}

var
  frm_did: Tfrm_did;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_did }

function Tfrm_did.AcceptDIDs: string;
begin
  Result := 'PUT';
end;

function Tfrm_did.CancelDIDs(const AToken, ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_did.DIDs(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_did_read('+ QuotedStr(AToken) +');';

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

function Tfrm_did.UpdateDIDs: string;
begin
  Result := 'POST';
end;

end.
