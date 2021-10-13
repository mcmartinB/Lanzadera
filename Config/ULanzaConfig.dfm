object FMB2FrontEnd: TFMB2FrontEnd
  Left = 440
  Top = 483
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = '    My Backup 2 - Configuraci'#243'n'
  ClientHeight = 126
  ClientWidth = 481
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnAddFile: TSpeedButton
    Left = 448
    Top = 21
    Width = 23
    Height = 22
    Caption = '+f'
    OnClick = btnAddFileClick
  end
  object btnAddTarget: TSpeedButton
    Left = 448
    Top = 62
    Width = 23
    Height = 22
    Caption = '+d'
    OnClick = btnAddTargetClick
  end
  object Label1: TLabel
    Left = 8
    Top = 7
    Width = 60
    Height = 13
    Caption = 'Programa ....'
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 104
    Height = 13
    Caption = 'Actualizaciones en ....'
  end
  object btnCancel: TBitBtn
    Left = 321
    Top = 93
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 0
    TabStop = False
    OnClick = btnCancelClick
  end
  object btnOk: TBitBtn
    Left = 397
    Top = 93
    Width = 75
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 1
    TabStop = False
    OnClick = btnOkClick
  end
  object eDir: TEdit
    Left = 8
    Top = 63
    Width = 438
    Height = 21
    TabStop = False
    ReadOnly = True
    TabOrder = 2
  end
  object ePrograma: TEdit
    Left = 8
    Top = 22
    Width = 438
    Height = 21
    TabStop = False
    ReadOnly = True
    TabOrder = 3
  end
  object OpenDialog: TOpenDialog
    Filter = 'Ficheros ejecutables|*.exe'
    InitialDir = 'My Pc'
    Options = [ofReadOnly, ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Seleccione Fichero'
    Left = 280
    Top = 93
  end
end
