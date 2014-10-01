object frmNewMain: TfrmNewMain
  Left = 305
  Top = 210
  Width = 625
  Height = 647
  Caption = 'KEXIF'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pc: TPageControl
    Left = 0
    Top = 0
    Width = 617
    Height = 593
    Align = alClient
    HotTrack = True
    PopupMenu = pmTabs
    TabOrder = 0
    OnChange = pcChange
    OnContextPopup = pcContextPopup
  end
  object MainMenu1: TMainMenu
    Left = 64
    Top = 296
    object File1: TMenuItem
      Caption = '&File'
      object New1: TMenuItem
        Caption = '&New Tab'
        ShortCut = 16462
        OnClick = New1Click
      end
      object Open1: TMenuItem
        Caption = '&Open'
        ShortCut = 16463
        OnClick = Open1Click
      end
      object OpenNewTab1: TMenuItem
        Caption = 'Open (New &Tab)'
        ShortCut = 16468
        OnClick = OpenNewTab1Click
      end
      object Export1: TMenuItem
        Caption = 'Export'
        object Html1: TMenuItem
          Caption = 'HTML'
          Enabled = False
          OnClick = Html1Click
        end
        object JpgFromRaw1: TMenuItem
          Tag = 1
          Caption = 'Jpg From Raw'
          Enabled = False
          OnClick = Preview1Click
        end
        object Preview1: TMenuItem
          Tag = 2
          Caption = 'Preview'
          Enabled = False
          OnClick = Preview1Click
        end
        object Thumbnail1: TMenuItem
          Tag = 3
          Caption = 'Thumbnail'
          Enabled = False
          OnClick = Preview1Click
        end
        object XMP1: TMenuItem
          Caption = 'XMP'
          Enabled = False
          OnClick = XMP1Click
        end
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'E&xit'
        ShortCut = 16472
      end
    end
    object Edit1: TMenuItem
      Caption = '&Edit'
      object Options1: TMenuItem
        Caption = '&Options'
        OnClick = Options1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object IncreaseText1: TMenuItem
        Caption = 'Increase Text Size'
        ShortCut = 45
        OnClick = IncreaseText1Click
      end
      object DecreaseTextSize1: TMenuItem
        Caption = 'Decrease Text Size'
        ShortCut = 46
        OnClick = DecreaseTextSize1Click
      end
    end
    object Help1: TMenuItem
      Caption = '&Help'
      object About1: TMenuItem
        Caption = '&About'
        OnClick = About1Click
      end
    end
  end
  object od: TOpenDialog
    Filter = 
      'All Suported Files|*.3FR;*.ACR;*.AI;*.AIF;*.AIFC;*.AIFF;*.APE;*.' +
      'ARW;*.ASF;*.AVI;*.BMP;*.BTF;*.CIFF;*.CR2;*.CRW;*.CS1;*.DC3;*.DCM' +
      ';*.DCR;*.DIB;*.DIC;*.DICM;*.DNG;*.DOC;*.EPS;*.EPSF;*.ERF;*.FLAC;' +
      '*.FLV;*.FPX;*.GIF;*.HTM;*.HTML;*.ICC;*.ICM;*.JNG;*.JP2;*.JPEG;*.' +
      'JPG;*.JPX;*.K25;*.M4A;*.MEF;*.MIE;*.MIF;*.MIFF;*.MNG;*.MOS;*.MOV' +
      ';*.MP3;*.MP4;*.MPC;*.MPEG;*.MPG;*.MRW;*.NEF;*.OGG;*.ORF;*.PBM;*.' +
      'PCT;*.PDF;*.PEF;*.PGM;*.PICT;*.PNG;*.PPM;*.PPT;*.PS;*.PSD;*.QIF;' +
      '*.QT;*.QTI;*.QTIF;*.RA;*.RAF;*.RAM;*.RAW;*.RIF;*.RIFF;*.RM;*.RMV' +
      'B;*.RPM;*.RV;*.SR2;*.SRF;*.SWF;*.THM;*.TIF;*.TIFF;*.VRD;*.WAV;*.' +
      'WDP;*.WMA;*.WMV;*.X3F;*.XHTML;*.XLS;*.XMP;|3FR Files|*.3FR'
    Left = 80
    Top = 160
  end
  object pmTabs: TPopupMenu
    Left = 192
    Top = 24
    object Close1: TMenuItem
      Caption = 'Close'
      OnClick = Close1Click
    end
  end
  object sd: TSaveDialog
    DefaultExt = 'html'
    Filter = 'HTML Files|*.html'
    Left = 152
    Top = 160
  end
end
