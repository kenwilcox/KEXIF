object frmOptions: TfrmOptions
  Left = 192
  Top = 114
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 207
  ClientWidth = 266
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object rgDrag: TRadioGroup
    Left = 16
    Top = 16
    Width = 233
    Height = 89
    Caption = 'Drag N Drop'
    ItemIndex = 1
    Items.Strings = (
      'Open Draged Items in a New Tab'
      'Open Draged Items in the Current Tab'
      'I Hate Drag N'#39' Drop. Turn it off please!')
    TabOrder = 0
  end
  object cbPos: TCheckBox
    Left = 16
    Top = 120
    Width = 233
    Height = 17
    Caption = 'Remember Window Placement'
    TabOrder = 1
  end
  object bOK: TButton
    Left = 80
    Top = 168
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    OnClick = bOKClick
  end
  object bCancel: TButton
    Left = 168
    Top = 168
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
end
