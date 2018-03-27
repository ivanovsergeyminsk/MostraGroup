object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1058#1047' - '#1052#1086#1089#1090#1088#1072#1043#1088#1091#1087#1087
  ClientHeight = 422
  ClientWidth = 742
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 32
    Top = 112
    Width = 297
    Height = 265
    Alignment = taLeftJustify
    Caption = ' Panel1'
    TabOrder = 0
    VerticalAlignment = taAlignTop
    object ComX1: TComX
      Left = 56
      Top = 112
      Width = 150
      Height = 30
      ValueMin = 0
      ValueMax = 100
      ValueDefault = 0
      Role = Slave
      Publisher = ComX0
      OnAfterReactionToDependence = ComX1AfterReactionToDependence
    end
  end
  object Panel2: TPanel
    Left = 392
    Top = 112
    Width = 297
    Height = 265
    Alignment = taLeftJustify
    Caption = ' Panel2'
    TabOrder = 1
    VerticalAlignment = taAlignTop
    object Panel3: TPanel
      Left = 16
      Top = 112
      Width = 265
      Height = 145
      Alignment = taLeftJustify
      Caption = ' Panel3'
      TabOrder = 0
      VerticalAlignment = taAlignTop
      object ComX3: TComX
        Left = 56
        Top = 56
        Width = 150
        Height = 30
        ValueMin = 0
        ValueMax = 100
        ValueDefault = 0
        Role = Slave
        Publisher = ComX2
      end
    end
    object ComX2: TComX
      Left = 72
      Top = 48
      Width = 150
      Height = 30
      ValueMin = 0
      ValueMax = 100
      ValueDefault = 0
      Role = MasterAndSlave
      Publisher = ComX0
    end
  end
  object ComX0: TComX
    Left = 40
    Top = 32
    Width = 150
    Height = 30
    ValueMin = 0
    ValueMax = 100
    ValueDefault = 0
    Role = Master
  end
end
