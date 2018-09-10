unit ufrm_login;

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
  Tfrm_login = class(TDataModule)
  private

  public
    // FUNCTION GET
    function Logins(const AId: Int64; const AUsername, APassword: string): TJSONArray;

  end;

  Login = class(Tfrm_login)

  end;
{$METHODINFO OFF}

var
  frm_login: Tfrm_login;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_login }

function Tfrm_login.Logins(const AId: Int64; const AUsername, APassword: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL := 'set @po_valid_user  = 0;' +
         'set @po_ctr_usr_cod = 0;' +
         'set @po_ctr_token   = 0;' +
         'set @po_ctr_cod     = 0;' +
         'call proc_contract_user_signin(' + IntToStr(AId) + ', ' + QuotedStr(AUsername) + ', ' + QuotedStr(APassword) + ', @po_valid_user, @po_ctr_usr_cod, @po_ctr_token, @ctr_cod);' +
         'select @po_valid_user as valid_user, @po_ctr_usr_cod as ctr_usr_cod, @po_ctr_token as ctr_token, @ctr_cod as ctr_cod;';

  method := Tfrm_srvmethod.Create(Self);
  qry := TFDQuery.Create(Self);

  qry.Connection := method.conn_db;
  qry.Open(SQL);
  qry.Open(SQL);

  if not (qry.IsEmpty) then begin
    Result := qry.DataSetToJSON;
  end else begin
    Result := qry.DataSetToJSON;
  end;

  GetInvocationMetadata().ResponseCode := 200;
  GetInvocationMetadata().ResponseContent := Result.ToJSON;
end;

end.
