program LanzaConfig;

uses
  Forms,
  ULanzaConfig in 'ULanzaConfig.pas' {FMB2FrontEnd};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFMB2FrontEnd, FMB2FrontEnd);
  Application.Run;
end.
