unit ULanzaConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFMB2FrontEnd = class(TForm)
    btnCancel: TBitBtn;
    btnOk: TBitBtn;
    OpenDialog: TOpenDialog;
    btnAddFile: TSpeedButton;
    eDir: TEdit;
    btnAddTarget: TSpeedButton;
    ePrograma: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOkClick(Sender: TObject);
    procedure btnAddFileClick(Sender: TObject);
    procedure btnAddTargetClick(Sender: TObject);
  private
    { Private declarations }
    sFileName: string;

  public
    { Public declarations }
  end;

var
  FMB2FrontEnd: TFMB2FrontEnd;

implementation

uses FileCtrl, IniFiles;

{$R *.dfm}

procedure TFMB2FrontEnd.FormCreate(Sender: TObject);
var
  IniFile: TIniFile;
begin
  sFileName:= GEtCurrentDir + '\Lanzadera.Ini';

  if FileExists( sFileName ) then
  begin
    IniFile:= TIniFile.Create( sFileName );
    ePrograma.Text:= IniFile.ReadString('LANZADERA','PROGRAM','');
    eDir.Text:= IniFile.ReadString('LANZADERA','DIR','');
    FreeAndNil( IniFile );
  end;
end;

procedure TFMB2FrontEnd.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TFMB2FrontEnd.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFMB2FrontEnd.btnOkClick(Sender: TObject);
var
  IniFile: TIniFile;
begin
  IniFile:= TIniFile.Create( sFileName );
  IniFile.WriteString('LANZADERA','PROGRAM',ePrograma.Text);
  IniFile.WriteString('LANZADERA','DIR',eDir.Text);
  FreeAndNil( IniFile );

  Close;
end;

procedure TFMB2FrontEnd.btnAddTargetClick(Sender: TObject);
var
  sDir: string;
begin
  if Trim(eDir.Text) <> '' then
  begin
    sDir:= Trim(eDir.Text);
  end
  else
  begin
    sDir:= ExtractFileDir( sFileName );
  end;
  if SelectDirectory( 'Selecciona directorio', '' , sDir ) then
  begin
    eDir.Text:= sDir;
  end;
end;

procedure TFMB2FrontEnd.btnAddFileClick(Sender: TObject);
begin
  if Trim(ePrograma.Text) <> '' then
  begin
    OpenDialog.InitialDir:= ExtractFileDir(ePrograma.Text);
    OpenDialog.FileName:= ExtractFileName(ePrograma.Text);
  end
  else
  begin
    OpenDialog.InitialDir:= ExtractFileDir( sFileName );
  end;

  if OpenDialog.Execute then
  begin
    ePrograma.Text:= OpenDialog.FileName;
  end;
end;

end.
