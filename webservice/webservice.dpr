program webservice;
{$APPTYPE CONSOLE}

{$R *.dres}

uses
  System.SysUtils,
  System.Types,
  IPPeerServer,
  IPPeerAPI,
  IdHTTPWebBrokerBridge,
  Web.WebReq,
  Web.WebBroker,
  Datasnap.DSSession,
  ufrm_srvmethod in 'ufrm_srvmethod.pas' {frm_srvmethod: TDSServerModule},
  ufrm_webmodule in 'ufrm_webmodule.pas' {frm_webmodule: TWebModule},
  uclass_srvconst in 'uclass_srvconst.pas',
  ufrm_phonebook in 'ufrm_phonebook.pas' {frm_phonebook: TDataModule},
  ufrm_contract in 'ufrm_contract.pas' {frm_contract: TDataModule},
  ufrm_enterprise in 'ufrm_enterprise.pas' {frm_enterprise: TDataModule},
  ufrm_client in 'ufrm_client.pas' {frm_client: TDataModule},
  ufrm_contract_user in 'ufrm_contract_user.pas' {frm_contract_user: TDataModule},
  ufrm_login in 'ufrm_login.pas' {frm_login: TDataModule},
  u_ds_classhelper in 'u_ds_classhelper.pas',
  ufrm_reseller in 'ufrm_reseller.pas' {frm_reseller: TDataModule},
  ufrm_product in 'ufrm_product.pas' {frm_product: TDataModule},
  ufrm_client_contract in 'ufrm_client_contract.pas' {frm_client_contract: TDataModule},
  ufrm_client_contract_iten in 'ufrm_client_contract_iten.pas' {frm_client_contract_iten: TDataModule},
  ufrm_voip_server in 'ufrm_voip_server.pas' {frm_voip_server: TDataModule},
  ufrm_client_astpp in 'ufrm_client_astpp.pas' {frm_client_astpp: TDataModule},
  ufrm_client_sippulse in 'ufrm_client_sippulse.pas' {frm_client_sippulse: TDataModule},
  ufrm_print_astpp in 'ufrm_print_astpp.pas' {frm_print_astpp: TDataModule};

{$R *.res}

procedure TerminateThreads;
begin
  if TDSSessionManager.Instance <> nil then
    TDSSessionManager.Instance.TerminateAllSessions;
end;

function BindPort(Aport: Integer): Boolean;
var
  LTestServer: IIPTestServer;
begin
  Result := True;
  try
    LTestServer := PeerFactory.CreatePeer('', IIPTestServer) as IIPTestServer;
    LTestServer.TestOpenPort(APort, nil);
  except
    Result := False;
  end;
end;

function CheckPort(Aport: Integer): Integer;
begin
  if BindPort(Aport) then
    Result := Aport
  else
    Result := 0;
end;

procedure SetPort(const Aserver: TIdHTTPWebBrokerBridge; APort: String);
begin
  if not (Aserver.Active) then
  begin
    APort := APort.Replace(cCommandSetPort, '').Trim;
    if CheckPort(APort.ToInteger) > 0 then
    begin
      Aserver.DefaultPort := APort.ToInteger;
      Writeln(Format(sPortSet, [APort]));
    end
    else
      Writeln(Format(sPortInUse, [Aport]));
  end
  else
    Writeln(sServerRunning);
  Write(cArrow);
end;

procedure StartServer(const Aserver: TIdHTTPWebBrokerBridge);
begin
  if not (Aserver.Active) then
  begin
    if CheckPort(Aserver.DefaultPort) > 0 then
    begin
      Writeln(Format(sStartingServer, [Aserver.DefaultPort]));
      Aserver.Bindings.Clear;
      Aserver.Active := True;
    end
    else
      Writeln(Format(sPortInUse, [Aserver.DefaultPort.ToString]));
  end
  else
    Writeln(sServerRunning);
  Write(cArrow);
end;

procedure StopServer(const Aserver: TIdHTTPWebBrokerBridge);
begin
  if Aserver.Active  then
  begin
    Writeln(sStoppingServer);
    TerminateThreads;
    Aserver.Active := False;
    Aserver.Bindings.Clear;
    Writeln(sServerStopped);
  end
  else
    Writeln(sServerNotRunning);
  Write(cArrow);
end;

procedure WriteCommands;
begin
  Writeln(sCommands);
  Write(cArrow);
end;

procedure WriteStatus(const Aserver: TIdHTTPWebBrokerBridge);
begin
  Writeln(sIndyVersion + Aserver.SessionList.Version);
  Writeln(sActive + Aserver.Active.ToString(TUseBoolStrs.True));
  Writeln(sPort + Aserver.DefaultPort.ToString);
  Writeln(sSessionID + Aserver.SessionIDCookieName);
  Write(cArrow);
end;

procedure RunServer(APort: Integer);
var
  LServer: TIdHTTPWebBrokerBridge;
  LResponse: string;
begin
  WriteCommands;
  LServer := TIdHTTPWebBrokerBridge.Create(nil);
  try
    LServer.DefaultPort := APort;
    while True do
    begin
      Readln(LResponse);
      LResponse := LowerCase(LResponse);
      if LResponse.StartsWith(cCommandSetPort) then
        SetPort(LServer, LResponse)
      else if sametext(LResponse, cCommandStart) then
        StartServer(LServer)
      else if sametext(LResponse, cCommandStatus) then
        WriteStatus(LServer)
      else if sametext(LResponse, cCommandStop) then
        StopServer(LServer)
      else if sametext(LResponse, cCommandHelp) then
        WriteCommands
      else if sametext(LResponse, cCommandExit) then
        if LServer.Active then
        begin
          StopServer(LServer);
          break
        end
        else
          break
      else
      begin
        Writeln(sInvalidCommand);
        Write(cArrow);
      end;
    end;
    TerminateThreads();
  finally
    LServer.Free;
  end;
end;

begin
  try
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
    RunServer(80);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end
end.
