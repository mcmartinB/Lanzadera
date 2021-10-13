unit ULanzadera;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls;

type
  TFLanzadera = class(TForm)
    Timer: TTimer;
    lblMsg: TLabel;
    OpenDialog: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TimerTimer(Sender: TObject);
  private
    { Private declarations }
    sFileName: string;
    sProgramaLocal, sVersionLocal, sLocalBorrar, sLocalOld: string;
    sDireccionRemota, sProgramaRemoto, sVersionRemota: string;
    bProgram, bDir: Boolean;
    iLocalMayorVersion, iLocalMenorVersion, iLocalCompilacion: Integer;
    iRemotoMayorVersion, iRemotoMenorVersion, iRemotoCompilacion: Integer;

    procedure Lanzamiento;

    function ValidarPrograma: boolean;
    function ValidarDirectorio: boolean;
    function SeleccionarPrograma: boolean;
    function SeleccionarDirectorio: boolean;

    procedure ActualizarPrograma;
    function  GetVersionLocal: boolean;
    function  GetVersionRemota: boolean;
    procedure NuevaVersion;

    procedure LanzarPrograma;

    procedure MsgCambioVersion;
    procedure Log( const AMsg: string );
  public
     { Public declarations }
  end;

var
  FLanzadera: TFLanzadera;

implementation

uses
  IniFiles, ShellAPI, FileCtrl, UActualizarDir;

{$R *.dfm}


procedure BorrarFicheros( const AFileName: string );
var
  i: integer;
  srFile: TSearchRec;
  slFileNames: TStringList;
  sRuta: string;
begin
  if FindFirst( AFileName, faArchive, srFile ) = 0 then
  begin
    sRuta:= ExtractFilePath( AFileName );
    if Copy( SRuta, length( sRuta ), 1 ) <> '\' then
      SRuta:= SRuta + '\';
    slFileNames:= TStringList.Create;
    slFileNames.Add( sRuta + srFile.Name );
    while FindNext( srFile ) = 0 do
    begin
      slFileNames.Add( sRuta + srFile.Name );
    end;
    for i:= 0 to slFileNames.Count - 1 do
    begin
      DeleteFile( slFileNames[i] );
    end;
  end;
end;


procedure TFLanzadera.FormCreate(Sender: TObject);
begin
  sFileName:= GEtCurrentDir + '\Lanzadera.Ini';
  sProgramaLocal:= '';
  sDireccionRemota:= '';
end;

procedure TFLanzadera.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TFLanzadera.MsgCambioVersion;
begin
  Log(' Cambio de V.' + IntToStr( iLocalMayorVersion ) + '.' +
                        IntToStr( iLocalMenorVersion ) + '.' +
                        IntToStr( iLocalCompilacion ) + ' a V.' +
                        IntToStr( iRemotoMayorVersion ) + '.' +
                        IntToStr( iRemotoMenorVersion ) + '.' +
                        IntToStr( iRemotoCompilacion ) );
end;

procedure TFLanzadera.Log( const AMsg: string );
var
  slAux: TStringList;
  sAux: string;
begin
  sAux:= Copy( sFileName, 1, Length( sFileName ) - 3 ) + 'log';
  slAux:= TStringList.Create;
  try
    if FileExists( sAux ) then
      slAux.LoadFromFile( sAux );

    if slAux.Count = 10 then
      slAux.Delete(0);

    slAux.Add( DatetimeToStr( Now ) + ' ' + Trim(AMsg) );
    slAux.SaveToFile( sAux );
  finally
    FreeAndNil(slAux);
  end
end;

procedure TFLanzadera.TimerTimer(Sender: TObject);
begin
  Timer.Enabled:= False;
  Lanzamiento;
end;

procedure TFLanzadera.Lanzamiento;
var
  IniFile: TIniFile;
begin
  if FileExists( sFileName ) then
  begin
    IniFile:= TIniFile.Create( sFileName );
    sProgramaLocal:= IniFile.ReadString('LANZADERA','PROGRAMA','');
    sDireccionRemota:= IniFile.ReadString('LANZADERA','ACTUALIZACION','');
    FreeAndNil( IniFile );
  end;
  bProgram:= sProgramaLocal <> '';
  bDir:= sDireccionRemota <> '';

  if ValidarPrograma then
  begin
    if ValidarDirectorio then
    begin
      ActualizarPrograma;
    end;
    LanzarPrograma;
  end
  else
  begin
    Log('ERROR: Programa a ejecutar sin seleccionar.');
  end;
  Close;
end;

function TFLanzadera.ValidarPrograma: boolean;
var
  IniFile: TIniFile;
  bWrite: boolean;
begin
  bWrite:= False;

  if not bProgram then
  begin
    ShowMessage('Por favor, ahora seleccione el programa que quiere ejecutar ....');
    result:= SeleccionarPrograma;
    bWrite:= result;
  end
  else
  begin
    if not FileExists( sProgramaLocal ) then
    begin
      ShowMessage('Programa a lanzar no valido, por favor seleccionelo ahora ... ');
      sProgramaLocal:= '';
      result:= SeleccionarPrograma;
      bWrite:= result;
    end
    else
    begin
      result:= True;
    end;
  end;

  if result then
  begin
    sVersionLocal:= copy( sProgramaLocal, 1, length( sProgramaLocal ) - 3 ) + 'ver';
    sLocalBorrar:=  sProgramaLocal + '.borrar';
    sLocalOld:=  sProgramaLocal + '.old';
  end;

  if bWrite then
  begin
    IniFile:= TIniFile.Create( sFileName );
    IniFile.WriteString('LANZADERA','PROGRAMA',sProgramaLocal);
    FreeAndNil( IniFile );
  end;
end;

function TFLanzadera.ValidarDirectorio: boolean;
var
  IniFile: TIniFile;
  bWrite: boolean;
begin
  bWrite:= False;

  if bDir then
  begin
    //Existe dir
    if not DirectoryExists( sDireccionRemota ) then
    begin
      //result:= ActualizarDir( sDireccionRemota );
      bWrite:= result;
      Log('AVISO: No se puede acceder a la carpeta remota (' + sDireccionRemota + ').' );
    end
    else
    begin
      result:= True;
    end;
  end
  else
  begin
    ShowMessage('Por favor, ahora seleccione la carpeta remota donde se encuentran las actualizaciones ...');
    result:= SeleccionarDirectorio;
    bWrite:= result;
  end;

  if result then
  begin
    if copy( sDireccionRemota, length( sDireccionRemota ), 1 ) <> '\' then
      sDireccionRemota:= sDireccionRemota + '\';
    sProgramaRemoto:=  sDireccionRemota + ExtractFileName( sProgramaLocal );
    sVersionRemota:=  sDireccionRemota + ExtractFileName( sVersionLocal );
  end;

  if bWrite then
  begin
    IniFile:= TIniFile.Create( sFileName );
    IniFile.WriteString('LANZADERA','ACTUALIZACION',sDireccionRemota);
    FreeAndNil( IniFile );
  end;
end;

function TFLanzadera.GetVersionLocal: boolean;
var
  sAux: string;
  slAux: TStringList;
begin
  slAux:= TStringList.Create;
  if FileExists( sVersionLocal ) then
  begin
    try
      slAux.LoadFromFile( sVersionLocal );
      sAux:= Trim( slAux.Text );
      if TryStrToInt( Copy( sAux, 1, 1 ), iLocalMayorVersion ) and
        TryStrToInt( Copy( sAux, 3, 2 ), iLocalMenorVersion ) and
        TryStrToInt( Copy( sAux, 6, 5 ), iLocalCompilacion ) then
      begin
         result:= True;
      end
      else
      begin
        result:= False;
      end;
    except
      result:= False;
    end;
  end
  else
  begin
    result:= False;
  end;
  FreeAndNil(slAux);
end;

function TFLanzadera.GetVersionRemota: boolean;
var
  sAux: string;
  slAux: TStringList;
begin
  slAux:= TStringList.Create;
  if FileExists( sVersionRemota ) then
  begin
    try
      slAux.LoadFromFile( sVersionRemota );
      sAux:= Trim( slAux.Text );
      if TryStrToInt( Copy( sAux, 1, 1 ), iRemotoMayorVersion ) and
        TryStrToInt( Copy( sAux, 3, 2 ), iRemotoMenorVersion ) and
        TryStrToInt( Copy( sAux, 6, 5 ), iRemotoCompilacion ) then
      begin
         result:= True;
      end
      else
      begin
        result:= False;
        Log('AVISO: Error en el formato del fichero de versión remoto');
      end;
    except
      result:= False;
      Log('AVISO: Error al leer el fichero de versión remoto');
    end;
  end
  else
  begin
    result:= False;
    Log('AVISO: Fichero de versión remoto inexistente o inaccesible.');
  end;
  FreeAndNil(slAux);
end;

procedure TFLanzadera.NuevaVersion;
begin
  if FileExists( sProgramaRemoto ) then
  begin
    //Primero copias version remota como aux
    if CopyFile(Pchar(sProgramaRemoto), Pchar(sProgramaLocal + '.aux'), True) then
    begin
      //Borrar temporales
      BorrarFicheros( sLocalBorrar + '*' );
      //Crear nuevo temporal
      RenameFile( sLocalOld, sLocalBorrar + '.' + FormatDateTime( 'yymmddhhnnss', Now ) );
      //Copia del ejecutable actual
      RenameFile( sProgramaLocal, sLocalOld );
      //Nuevo programa
      RenameFile( sProgramaLocal + '.aux', sProgramaLocal );

      MsgCambioVersion;

      if FileExists( sVersionRemota ) then
      begin
        if CopyFile( Pchar(sVersionRemota), Pchar(sVersionLocal + '.aux'), True ) then
        begin
          DeleteFile( sVersionLocal );
          RenameFile( sVersionLocal + '.aux', sVersionLocal )
        end;
      end;
    end;
  end;
end;

procedure TFLanzadera.ActualizarPrograma;
begin
  //Fichero con la version remota
  if GetVersionRemota then
  begin
    //Fichero con la version loccal
    if GetVersionLocal then
    begin
      if ( iLocalCompilacion < iRemotoCompilacion ) or ( iLocalMayorVersion < iRemotoMayorVersion ) or ( iLocalMenorVersion < iRemotoMenorVersion ) then
      begin
        NuevaVersion;
      end;
    end
    else
    begin
      //No hay version local
      NuevaVersion;
    end;
  end
  else
  begin
    //No hay version remota
    Log('AVISO: No hay ficheo de version remota.');
  end;
end;

procedure TFLanzadera.LanzarPrograma;
var
  iaux: integer;
begin
  //Nada
  if Trim(ParamStr(1)) <> '' then
  begin
    iAux:= ShellExecute( 0, 'open', PCHAR(sProgramaLocal), PCHAR( Trim(ParamStr(1)) ), PCHAR(ExtractFileDir(sProgramaLocal)), SW_SHOWMAXIMIZED )
  end
  else
    iAux:= ShellExecute( 0, 'open', PCHAR(sProgramaLocal), '', PCHAR(ExtractFileDir(sProgramaLocal)), SW_SHOWMAXIMIZED );
  if iAux < 33 then
  begin
    ShowMessage('Error, pongase en contacto con el departamento de informática.');
  end
  else
  begin
    ShowWindow( iAux, SW_RESTORE);
  end;
end;

function TFLanzadera.SeleccionarPrograma: boolean;
begin
  OpenDialog.Title:= 'Seleccione programa.';
  if sProgramaLocal <> '' then
  begin
    OpenDialog.InitialDir:= ExtractFileDir(sProgramaLocal);
    OpenDialog.FileName:= ExtractFileName(sProgramaLocal);
  end
  else
  begin
    OpenDialog.InitialDir:= ExtractFileDir( sFileName );
  end;
  result:= OpenDialog.Execute;
  sProgramaLocal:= OpenDialog.FileName;
end;

function TFLanzadera.SeleccionarDirectorio: boolean;
var
  sAux: string;
begin
  if Trim(sDireccionRemota) <> '' then
  begin
    sAux:= Trim(sDireccionRemota);
  end
  else
  begin
    sAux:= ExtractFileDir( sFileName );
  end;

  result:= SelectDirectory( 'Selecciona directorio con las actualizaciones ...', '' , sAux );
  sDireccionRemota:= sAux
end;


end.
