{*******************************************************}
{                                                       }
{                    Landerson Gomes                    }
{                                                       }
{*       Class Helper para Classes TDataSet            *}
{                                                       }
{*******************************************************}


unit u_ds_classhelper;

interface

uses
  Data.DB, System.JSON, REST.Json, System.NetEncoding;

  Type
    TDataSetHelper = class Helper for TDataSet
    public
      function DataSetToJSON () : TJSonArray;
      procedure SaveToJSON(aFileName : string);
    end;

implementation

uses
  System.Classes;

{ TDataSetHelper }

function TDataSetHelper.DataSetToJSON: TJSonArray;
var
  lRow, lCol : integer;
  lJO : TJSONObject;

  StreamIn: TStream;
  StreamOut : TStringStream;

begin
  Result := TJSONArray.Create;
  First;
  for lRow := 0 to RecordCount -1 do
    begin
      lJO := TJSONObject.Create;
      for lCol := 0 to FieldCount - 1 do
        begin
          if Fields[lCol].IsNull then
            lJO.AddPair(Fields[lCol].FieldName, '')
          else
            begin
              if (Fields[lCol].IsBlob) and (Fields[lCol].DisplayName <> 'ctr_usr_cod') and (Fields[lCol].DisplayName <> 'ctr_token') and
                  (Fields[lCol].DisplayName <> 'ctr_cod') and (Fields[lCol].DisplayName <> 'pro_annotation')then
                begin
                  StreamIn := CreateBlobStream(Fields[lCol], bmRead);
                  StreamOut := TStringStream.Create;
                  TNetEncoding.Base64.Encode(StreamIn, StreamOut);
                  StreamOut.Position := 0;
                  lJO.AddPair(Fields[lCol].DisplayName, StreamOut.DataString);
                end else begin
                  if Fields[lCol].DataType in [ftCurrency, ftFloat, ftInteger, ftSmallint, ftSingle ] then
                    lJO.AddPair(Fields[lCol].FieldName,
                                TJSONNumber.Create(Fields[lcol].Value))
                  else
                    lJO.AddPair(fields[lcol].FieldName, fields[lcol].Value);
                end;
            end;

        end;
      Result.AddElement(lJO);
      Next;
    end;
end;

procedure TDataSetHelper.SaveToJSON(aFileName: string);
var
  S : TStringList;
begin
  S  := TStringList.Create;
  S.Clear;
  S.Add(TJSON.Format(DataSetToJSON));
  S.SaveToFile(aFileName);
end;

end.

