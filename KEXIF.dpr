program KEXIF;

uses
  Forms,
  uMain in 'uMain.pas' {frmMain},
  uNewMain in 'uNewMain.pas' {frmNewMain},
  uConsole in 'uConsole.pas',
  uOptions in 'uOptions.pas' {frmOptions},
  uGlobal in 'uGlobal.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmNewMain, frmNewMain);
  Application.Run;
end.
