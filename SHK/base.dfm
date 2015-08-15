object Form1: TForm1
  Left = 168
  Top = 128
  Width = 843
  Height = 552
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 24
    Top = 72
    Width = 777
    Height = 409
    TabOrder = 0
  end
  object Button2: TButton
    Left = 184
    Top = 24
    Width = 113
    Height = 25
    Caption = 'Add village'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Edit2: TEdit
    Left = 48
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Name village'
    OnKeyPress = EditKeyPress
  end
  object ProgressBars1: TProgressBar
    Left = 384
    Top = 32
    Width = 150
    Height = 17
    TabOrder = 3
    Visible = False
  end
  object Timers1: TTimer
    Enabled = False
    OnTimer = Timers1Timer
    Left = 776
    Top = 8
  end
end
