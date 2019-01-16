unit ufrm_webservice;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Actions,
  System.ImageList,
  System.IniFiles,

  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.ActnList,
  FMX.ImgList,
  FMX.StdCtrls,
  FMX.Controls.Presentation,
  FMX.Edit,

  uDWAbout,
  uRESTDWBase,

  ufrm_dm;

type
  Tfrm_webservice = class(TForm)
    servicePooler: TRESTServicePooler;
    ImageList_1: TImageList;
    ActionList_1: TActionList;
    StatusBar_1: TStatusBar;
    Panel_bottom: TPanel;
    Button_iniciar: TButton;
    Button_parar: TButton;
    Button_fechar: TButton;
    Action_iniciar: TAction;
    Action_parar: TAction;
    Action_fechar: TAction;
    Panel_top: TPanel;
    Label_top: TLabel;
    procedure Action_iniciarExecute(Sender: TObject);
    procedure Action_pararExecute(Sender: TObject);
    procedure Action_fecharExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    arqIni: TIniFile;

    arqIniServidorWBS: TIniFile;
    dir: String;

    CONST
      pasta           = 'config\';
      fileServidorWBS = 'swebservice.ini';

    procedure statusButton;

  public

  end;

var
  frm_webservice: Tfrm_webservice;

implementation

{$R *.fmx}

{ Tfrm_webservice }

procedure Tfrm_webservice.Action_fecharExecute(Sender: TObject);
begin
  if servicePooler.Active then begin
    servicePooler.Active := False;
    Close;
  end else begin
    Close;
  end;
end;

procedure Tfrm_webservice.Action_iniciarExecute(Sender: TObject);
var
  dir: String;
begin
  dir := ExtractFilePath(ExtractFileDir(GetCurrentDir)) + pasta + fileServidorWBS;

  try
    try
      arqIniServidorWBS := TIniFile.Create(dir);

      servicePooler.ServicePort := arqIniServidorWBS.ReadInteger('SWBS', 'SERVIDOR_PORTA', 80);
      servicePooler.ServerParams.HasAuthentication := arqIniServidorWBS.ReadBool('SWBS', 'SERVIDOR_AUTENTICACAO', True);
      servicePooler.ServerParams.UserName := arqIniServidorWBS.ReadString('SWBS', 'SERVIDOR_USUARIO', 'root');
      servicePooler.ServerParams.Password := arqIniServidorWBS.ReadString('SWBS', 'SERVIDOR_SENHA', 'root');

      servicePooler.Active := not servicePooler.Active;
      statusButton;

    except on E: Exception do
      ShowMessage('Error: ' + E.Message);
    end;
  finally
    arqIniServidorWBS.Free;
  end;
end;

procedure Tfrm_webservice.Action_pararExecute(Sender: TObject);
begin
  servicePooler.Active := not servicePooler.Active;
  statusButton;
end;

procedure Tfrm_webservice.FormCreate(Sender: TObject);
begin
  servicePooler.ServerMethodClass := Tfrm_dm;
end;

procedure Tfrm_webservice.statusButton;
begin
  if servicePooler.Active then begin
    Button_iniciar.Enabled := False;
    Button_parar.Enabled := True;
  end else begin
    Button_iniciar.Enabled := True;
    Button_parar.Enabled := False;
  end;
end;

end.
