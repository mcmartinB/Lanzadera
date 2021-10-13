unit UActualizarDir;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFActualizarDir = class(TForm)
    lblDir: TLabel;
    lbl1_: TLabel;
    lbl2: TLabel;
    lbl4: TLabel;
    lbl3: TLabel;
    lbl5: TLabel;
    btnCambiar: TButton;
    btnIgnorar: TButton;
    lblMsg: TLabel;
    Timer: TTimer;
    procedure btnIgnorarClick(Sender: TObject);
    procedure btnCambiarClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    { Private declarations }
    bResult: boolean;
    sDir: string;
  public
    { Public declarations }
  end;

  function ActualizarDir( var ADir: String ): boolean;

implementation

uses FileCtrl;

{$R *.dfm}

function ActualizarDir( var ADir: String ): boolean;
var
  FActualizarDir: TFActualizarDir;
begin
  FActualizarDir:= TFActualizarDir.Create(nil);
  FActualizarDir.sDir:= ADir;
  FActualizarDir.lblDir.Caption:= ADir;
  FActualizarDir.ShowModal;
  result:= FActualizarDir.bResult;
  if result then
  begin
    ADir:= FActualizarDir.sDir;
  end;
  FreeAndNil( FActualizarDir );
end;


procedure TFActualizarDir.btnIgnorarClick(Sender: TObject);
begin
  bResult:= False;
  Close;
end;

procedure TFActualizarDir.btnCambiarClick(Sender: TObject);
var
  sAux: string;
begin
  sAux:= Trim(sDir);
  bResult:= SelectDirectory( 'Selecciona directorio', '' , sAux );
  sDir:= sAux;
  Close;
end;

procedure TFActualizarDir.TimerTimer(Sender: TObject);
begin
  btnIgnorar.Click;
end;

end.
