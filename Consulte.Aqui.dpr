program Consulte.Aqui;

uses
  System.StartUpCopy,
  FMX.Forms,
  uConsultaCNPJ in 'uConsultaCNPJ.pas' {FrmPrincipal},
  uFunctions in 'unit\uFunctions.pas',
  uFormat in 'unit\uFormat.pas',
  uFancyDialog in 'unit\uFancyDialog.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
