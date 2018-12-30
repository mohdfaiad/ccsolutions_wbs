unit ufrm_dm;

interface

uses
  System.SysUtils,
  System.Classes,

  uDWDataModule, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, uDWAbout, uRESTDWPoolerDB, uRestDWDriverFD,
  FireDAC.Phys.MySQLDef, FireDAC.Comp.UI, FireDAC.Phys.MySQL;

type
  Tfrm_dm = class(TServerMethodDataModule)
    connDB: TFDConnection;
    rdwDriver: TRESTDWDriverFD;
    poolerDB: TRESTDWPoolerDB;
    mysqlDriver: TFDPhysMySQLDriverLink;
    waitCursor: TFDGUIxWaitCursor;
  private

  public

  end;

var
  frm_dm: Tfrm_dm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
