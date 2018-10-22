unit ufrm_phonebook;

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
  Tfrm_phonebook = class(TDataModule)
  private

  public
    //FUNCTION GET
    function Phonebooks (const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptPhonebooks : string;
    //FUNCTION POST
    function UpdatePhonebooks : string;
    //FUNCTION DELETE
    function CancelPhonebooks (const AToken, ACod: string): string;

  end;

  Phonebook = class(Tfrm_phonebook)

  end;
{$METHODINFO OFF}

var
  frm_phonebook: Tfrm_phonebook;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

function Tfrm_phonebook.CancelPhonebooks(const AToken, ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_phonebook.Phonebooks(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_phonebook_read('+ QuotedStr(AToken) +');';
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

function Tfrm_phonebook.AcceptPhonebooks: string;
begin
  Result := 'PUT';
end;

function Tfrm_phonebook.UpdatePhonebooks: string;
begin
  Result := 'POST';
end;

end.
