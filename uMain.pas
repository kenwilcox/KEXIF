unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, HTMLLite, ShellApi, Menus, ExtCtrls;

type
  TfrmMain = class(TForm)
    PopupMenu1: TPopupMenu;
    Find1: TMenuItem;
    fd: TFindDialog;
    Panel1: TPanel;
    eFile: TEdit;
    Panel2: TPanel;
    Panel3: TPanel;
    html: ThtmlLite;
    Animate1: TAnimate;
    Copy1: TMenuItem;
    Find2: TMenuItem;
    eSize: TEdit;
    procedure Find1Click(Sender: TObject);
    procedure fdFind(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure eFileChange(Sender: TObject);
    procedure htmlProcessing(Sender: TObject; ProcessingOn: Boolean);
    procedure Copy1Click(Sender: TObject);
  private
    { Private declarations }
    sl: TStringList;
  public
    { Public declarations }
    TabSheet: TTabSheet;
    CanSave: Boolean;
    procedure GetEXIF(filename: string);
    procedure SaveHTML(filename: string);
    procedure SaveXMP(filename: string);
    procedure ExtractData(filename, arg, msg: string);
  end;

var
  frmMain: TfrmMain;
(*
 Configuration: options I like
 exiftool -a -u -g1 -s -h -w tmp/%f_%e.html $filename

 C:\Documents and Settings\wilcoxwk\Desktop>exiftool -a -u -g1 -s -h -w tmp/%f_%e
.html
*)
implementation

uses uConsole;

{$R *.dfm}

procedure TfrmMain.GetEXIF(filename: string);
var
  input, args: string;
begin
  // Shell execute, to output file, read output file in html browser
  eFile.Text := filename;
  input := '"' + filename + '"';

  args := '-a -u -g1 -s -h ';
  // exiftool -xmp -b $file > out.xmp
  // exiftool -icc_profile -b -w icc $file
  // exiftool -listf // file exten?
  // exiftool -b -ThumbnailImage image.jpg > thumbnail.jpg
  args := args + input;

//  Button1.Enabled := False;
  Animate1.Visible := True;
  Animate1.Active := True;
  html.Clear;
  //sl := TStringList.Create;
  //try
  sl.Clear;
  CaptureConsoleOutput('exiftool ' + args, sl);
  html.LoadStrings(sl, input);

  //finally
  //  FreeAndNil(sl);
  //end;
  Animate1.Active := False;
  Animate1.Visible := False;
//  Button1.Enabled := True;

  if Assigned(TabSheet) then
    TabSheet.Caption := ExtractFileName(filename);
  html.SetFocus;
end;

procedure TfrmMain.SaveXMP(filename: string);
var
  input, args: string;
begin
  // Shell execute, to output file, read output file in html browser
  input := '"' + eFile.Text + '"';

  args := '-xmp -b ';
  // exiftool -xmp -b $file > out.xmp
  // exiftool -icc_profile -b -w icc $file
  // exiftool -listf // file exten?
  args := args + input;

//  Button1.Enabled := False;
  Animate1.Visible := True;
  Animate1.Active := True;
  //html.Clear;
  //sl := TStringList.Create;
  //try
  sl.Clear;
  CaptureConsoleOutput('exiftool ' + args, sl);
  //html.LoadStrings(sl, input);

  //finally
  //  FreeAndNil(sl);
  //end;
  if Length(sl.Text) > 0 then
    sl.SaveToFile(filename)
  else
    MessageBox(0, pchar('Could not extract xmp data'), 'KEXIF-ERROR', MB_OK);
  Animate1.Active := False;
  Animate1.Visible := False;
//  Button1.Enabled := True;

//  if Assigned(TabSheet) then
//    TabSheet.Caption := ExtractFileName(filename);
 // html.SetFocus;
end;

procedure TfrmMain.ExtractData(filename, arg, msg: string);
var
  input, args: string;
begin
  // Shell execute, to output file, read output file in html browser
  input := '"' + eFile.Text + '"';
  filename := '"' + filename + '" ';

  //args := '-b -PreviewImage ';
  //args := '-b -JpgFromRaw -w ' + filename;
  args := '-b -'+arg+' -w ' + filename;
  args := args + input;

  Animate1.Visible := True;
  Animate1.Active := True;

  sl.Clear;
  CaptureConsoleOutput('exiftool ' + args, sl);

  filename := StringReplace(filename, '"', '', [rfReplaceall]);
  input := ChangeFileExt(eFile.Text, filename);
  if not FileExists(input) then
    MessageBox(0, pchar('Could not extract '+msg+' data'), 'KEXIF-ERROR', MB_OK);

  Animate1.Active := False;
  Animate1.Visible := False;

end;

procedure TfrmMain.Find1Click(Sender: TObject);
begin
  fd.Execute
end;

procedure TfrmMain.fdFind(Sender: TObject);
begin
  if frMatchCase in fd.Options then
    html.Find(fd.FindText, true)
  else
    html.Find(fd.FindText, false);
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(sl);
  Action := caFree;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  sl := TStringList.Create;
end;

procedure TfrmMain.SaveHTML(filename: string);
begin
  sl.SaveToFile(Filename);
end;

procedure TfrmMain.eFileChange(Sender: TObject);
begin
  CanSave := eFile.Text <> '';
end;

procedure TfrmMain.htmlProcessing(Sender: TObject; ProcessingOn: Boolean);
begin
  Animate1.Active := ProcessingOn;
  Animate1.Visible := not ProcessingOn;
end;

procedure TfrmMain.Copy1Click(Sender: TObject);
begin
  html.CopyToClipboard;
end;

end.
