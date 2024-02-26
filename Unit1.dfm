object Form1: TForm1
  Left = 10
  Top = 10
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Sudoku'
  ClientHeight = 627
  ClientWidth = 810
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -48
  Font.Name = 'Times New Roman'
  Font.Style = [fsBold]
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 55
  object sgData: TStringGrid
    Left = 8
    Top = 8
    Width = 601
    Height = 601
    ColCount = 9
    DefaultRowHeight = 64
    FixedCols = 0
    RowCount = 9
    FixedRows = 0
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -56
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    GridLineWidth = 2
    Options = [goVertLine, goHorzLine, goEditing, goThumbTracking]
    ParentFont = False
    ScrollBars = ssNone
    TabOrder = 0
    OnDrawCell = sgDataDrawCell
    OnExit = sgDataExit
  end
  object bRun: TButton
    Left = 624
    Top = 24
    Width = 145
    Height = 49
    Caption = 'Run'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = bRunClick
  end
  object edFile: TEdit
    Left = 624
    Top = 96
    Width = 145
    Height = 27
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    Text = 's1'
  end
  object bSave: TButton
    Left = 624
    Top = 136
    Width = 65
    Height = 25
    Caption = 'Save'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = bSaveClick
  end
  object bLoad: TButton
    Left = 704
    Top = 136
    Width = 65
    Height = 25
    Caption = 'Load'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = bLoadClick
  end
  object bCheck: TButton
    Left = 624
    Top = 180
    Width = 145
    Height = 49
    Caption = 'Check'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = bCheckClick
  end
end
