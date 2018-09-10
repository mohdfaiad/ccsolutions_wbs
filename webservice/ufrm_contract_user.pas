unit ufrm_contract_user;

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
  Tfrm_contract_user = class(TDataModule)
  private

  public
    //FUNCTION GET
    function Contract_User (const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptContract_User : string;
    //FUNCTION POST
    function UpdateContract_User : string;
    //FUNCTION DELETE
    function CancelContract_User (const AToken, ACod: string): string;

  end;

  contract_users = class(Tfrm_contract_user)

  end;
{$METHODINFO OFF}

var
  frm_contract_user: Tfrm_contract_user;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_contract_user }

function Tfrm_contract_user.AcceptContract_User: string;
begin
  Result := 'PUT';
end;

function Tfrm_contract_user.CancelContract_User(const AToken, ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_contract_user.Contract_User(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_contract_user_read('+ QuotedStr(AToken) +');';

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

function Tfrm_contract_user.UpdateContract_User: string;
begin
  Result := 'POST';
end;

end.
