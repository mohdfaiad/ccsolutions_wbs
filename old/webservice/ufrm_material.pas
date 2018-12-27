unit ufrm_material;

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
  Tfrm_material = class(TDataModule)
  private

  public
    //FUNCTION GET
    function Materials(const AToken: string): TJSONArray;
    //FUNCTION PUT
    function AcceptMaterials: string;
    //FUNCTION POST
    function UpdateMaterials: string;
    //FUNCTION DELETE
    function CancelMaterials(const AToken, ACod: string): string;

  end;

  Material = class(Tfrm_material)

  end;
{$METHODINFO OFF}

var
  frm_material: Tfrm_material;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ Tfrm_material }

function Tfrm_material.AcceptMaterials: string;
begin
  Result := 'PUT';
end;

function Tfrm_material.CancelMaterials(const AToken, ACod: string): string;
begin
  Result := 'DELETE';
end;

function Tfrm_material.Materials(const AToken: string): TJSONArray;
var
  SQL     : string;
  qry     : TFDQuery;
  method  : Tfrm_srvmethod;
begin
  SQL     := 'call proc_material_read('+ QuotedStr(AToken) +');';

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

function Tfrm_material.UpdateMaterials: string;
begin
  Result := 'POST';
end;

end.
