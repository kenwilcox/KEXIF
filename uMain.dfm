object frmMain: TfrmMain
  Left = 192
  Top = 114
  Width = 656
  Height = 625
  Caption = 'KEXIF'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 33
    Width = 648
    Height = 558
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      648
      558)
    object Panel3: TPanel
      Left = 8
      Top = 8
      Width = 633
      Height = 545
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelOuter = bvNone
      TabOrder = 0
      object html: ThtmlLite
        Left = 0
        Top = 0
        Width = 633
        Height = 545
        TabOrder = 0
        Align = alClient
        PopupMenu = PopupMenu1
        DefBackground = clWhite
        BorderStyle = htNone
        HistoryMaxCount = 1
        DefFontName = 'Tahoma'
        DefPreFontName = 'Courier New'
        DefFontSize = 8
        VisitedMaxCount = 1
        NoSelect = False
        CharSet = DEFAULT_CHARSET
        htOptions = []
        OnProcessing = htmlProcessing
        object Animate1: TAnimate
          Left = 7
          Top = 8
          Width = 41
          Height = 33
          Active = False
          AutoSize = False
          CommonAVI = aviFindFile
          StopFrame = 8
          Visible = False
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 648
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      648
      33)
    object eFile: TEdit
      Left = 8
      Top = 8
      Width = 633
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      ReadOnly = True
      TabOrder = 0
      OnChange = eFileChange
    end
    object eSize: TEdit
      Left = 616
      Top = 8
      Width = 25
      Height = 21
      Hint = 'Current Font Size'
      Anchors = [akTop, akRight]
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 1
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 96
    Top = 88
    object Find1: TMenuItem
      Caption = 'Find'
      ShortCut = 114
      OnClick = Find1Click
    end
    object Copy1: TMenuItem
      Caption = 'Copy'
      ShortCut = 16451
      OnClick = Copy1Click
    end
    object Find2: TMenuItem
      Caption = 'Find'
      ShortCut = 16454
      Visible = False
      OnClick = Find1Click
    end
  end
  object fd: TFindDialog
    Options = [frDown, frHideWholeWord, frHideUpDown]
    OnFind = fdFind
    Left = 176
    Top = 88
  end
end
