object FActualizarDir: TFActualizarDir
  Left = 415
  Top = 328
  Width = 478
  Height = 211
  Caption = '    DIRECTORIO DE ACTUALIZACI'#211'N'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblDir: TLabel
    Left = 8
    Top = 28
    Width = 171
    Height = 13
    Caption = 'C:\Directorio de actualizaci'#243'n'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl1_: TLabel
    Left = 8
    Top = 52
    Width = 455
    Height = 13
    Caption = 
      'Es posible que el directorio de actualizaciones no este disponib' +
      'le temporalmente, si este mensaje'
  end
  object lbl2: TLabel
    Left = 8
    Top = 64
    Width = 446
    Height = 13
    Caption = 
      'se repite continuadamente por favor pongalo en conocimiento del ' +
      'departamento de inform'#225'tica'
  end
  object lbl4: TLabel
    Left = 8
    Top = 134
    Width = 416
    Height = 13
    Caption = 
      'Ignorar: seguimos con la ejecuci'#243'n del programa sin comprobar si' +
      ' hay una actualizaci'#243'n.'
  end
  object lbl3: TLabel
    Left = 8
    Top = 121
    Width = 452
    Height = 13
    Caption = 
      'Cambiar: di'#225'logo que nos permite cambiar el directorio donde se ' +
      'encuentran las actualizaciones.'
  end
  object lbl5: TLabel
    Left = 8
    Top = 152
    Width = 345
    Height = 13
    Caption = 
      'Si no pulsa ninguna opci'#243'n en 15 segundos sera como si pulsara I' +
      'gnorar.'
  end
  object lblMsg: TLabel
    Left = 8
    Top = 7
    Width = 340
    Height = 13
    Caption = 
      'Directorio con las actualizaciones no v'#225'lido o no accesible actu' +
      'almente.'
  end
  object btnCambiar: TButton
    Left = 304
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Cambiar'
    TabOrder = 0
    OnClick = btnCambiarClick
  end
  object btnIgnorar: TButton
    Left = 384
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Ignorar'
    TabOrder = 1
    OnClick = btnIgnorarClick
  end
  object Timer: TTimer
    Interval = 15000
    OnTimer = TimerTimer
    Left = 424
    Top = 8
  end
end
