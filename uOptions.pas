unit uOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmOptions = class(TForm)
    rgDrag: TRadioGroup;
    cbPos: TCheckBox;
    bOK: TButton;
    bCancel: TButton;
    procedure bOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uGlobal;

{$R *.dfm}

procedure TfrmOptions.bOKClick(Sender: TObject);
begin
  ops.TabOpt := TTabOptions(rgDrag.ItemIndex);
  ops.RememberPos := cbPos.Checked;
end;

procedure TfrmOptions.FormCreate(Sender: TObject);
begin
  rgDrag.ItemIndex := Ord(ops.TabOpt);
  cbPos.Checked := ops.RememberPos;
end;

end.
