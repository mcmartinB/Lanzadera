object FLanzadera: TFLanzadera
  Left = 392
  Top = 250
  Caption = '   Actualizando programa ...'
  ClientHeight = 39
  ClientWidth = 474
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblMsg: TLabel
    Left = 8
    Top = 11
    Width = 320
    Height = 13
    Caption = 
      'Por favor espere mientras se comprueba si hay una nueva versi'#243'n ' +
      '..'
  end
  object Timer: TTimer
    Interval = 10
    OnTimer = TimerTimer
    Left = 424
    Top = 8
  end
  object OpenDialog: TOpenDialog
    Left = 384
    Top = 8
  end
end
