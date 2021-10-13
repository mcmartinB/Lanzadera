program Lanzadera;

uses
  Forms,
  UActualizarDir in 'UActualizarDir.pas' {FActualizarDir},
  ULanzadera in 'ULanzadera.pas' {FLanzadera};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFLanzadera, FLanzadera);
  Application.Run;
end.
