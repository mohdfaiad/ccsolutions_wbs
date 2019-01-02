unit ufrm_medicine;

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
  Tfrm_medicine = class(TDataModule)
  private

  public
    //FUNCTION GET
    function Medicines(const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptMedicines: string;
    //FUNCTION POST
    function UpdateMedicines: string;
    //FUNCTION DELETE
    function CancelMedicines(const AToken, ACod: string): string;

  end;

  Medicine = class(Tfrm_medicine)

  end;
{$METHODINFO OFF}

var
  frm_medicine: Tfrm_medicine;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_medicine }

function Tfrm_medicine.AcceptMedicines: string;
begin
  Result := 'PUT';
end;

function Tfrm_medicine.CancelMedicines(const AToken, ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_medicine.Medicines(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_medicine_read('+ QuotedStr(AToken) +');';

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

function Tfrm_medicine.UpdateMedicines: string;
begin
  Result := 'POST';
end;

end.
