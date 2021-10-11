program RegDate;

uses
  Forms,
  Properties in 'Properties.pas' {PropertyDlg},
  RegEdit in 'RegEdit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Registry Date/Time Demo';
  Application.CreateForm(TPropertyDlg, PropertyDlg);
  Application.Run;
end.
