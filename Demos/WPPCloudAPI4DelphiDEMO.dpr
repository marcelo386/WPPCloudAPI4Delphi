program WPPCloudAPI4DelphiDEMO;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uRetMensagemApiOficial in '..\Source\uRetMensagemApiOficial.pas',
  uWPPCloudAPI in '..\Source\uWPPCloudAPI.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
