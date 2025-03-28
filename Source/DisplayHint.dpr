program DisplayHint;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMain},
  DM.MenuHint in 'DM.MenuHint.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
