program WPPCloudAPI4DelphiDEMO;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uRetMensagemApiOficial in '..\Source\uRetMensagemApiOficial.pas',
  uWPPCloudAPI in '..\Source\uWPPCloudAPI.pas',
  uWhatsAppBusinessClasses in '..\Source\uWhatsAppBusinessClasses.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
