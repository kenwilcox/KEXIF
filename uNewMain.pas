unit uNewMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Menus, uMain, ShellAPI;

type
  TfrmNewMain = class(TForm)
    pc: TPageControl;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Help1: TMenuItem;
    New1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    od: TOpenDialog;
    pmTabs: TPopupMenu;
    Close1: TMenuItem;
    Export1: TMenuItem;
    Html1: TMenuItem;
    sd: TSaveDialog;
    OpenNewTab1: TMenuItem;
    XMP1: TMenuItem;
    Thumbnail1: TMenuItem;
    JpgFromRaw1: TMenuItem;
    Preview1: TMenuItem;
    Edit1: TMenuItem;
    Options1: TMenuItem;
    About1: TMenuItem;
    N2: TMenuItem;
    IncreaseText1: TMenuItem;
    DecreaseTextSize1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure New1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure pcContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure Html1Click(Sender: TObject);
    procedure OpenNewTab1Click(Sender: TObject);
    procedure XMP1Click(Sender: TObject);
    procedure pcChange(Sender: TObject);
    procedure Preview1Click(Sender: TObject);
    procedure Options1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure IncreaseText1Click(Sender: TObject);
    procedure DecreaseTextSize1Click(Sender: TObject);
  private
    { Private declarations }
    _idx: Integer;
    objlist: TStringList;
    procedure GetFileExts();
    function GetActiveForm:TfrmMain;
    procedure GetEXIF(filename: string);
    procedure HandleChange;
  public
    { Public declarations }
    procedure NewTab(filename:string = '');
    procedure AcceptFiles( var msg : TMessage );
    message WM_DROPFILES;
  end;

var
  frmNewMain: TfrmNewMain;

implementation

uses uConsole, uGlobal, uOptions;

{$R *.dfm}

procedure TfrmNewMain.HandleChange;
var
  frm: TfrmMain;
begin
  frm := GetActiveForm;
  if Assigned(frm) then
  begin
    HTML1.Enabled := frm.CanSave;
    XMP1.Enabled := frm.CanSave;
    Thumbnail1.Enabled := frm.CanSave;
    JpgFromRaw1.Enabled := frm.CanSave;
    Preview1.Enabled := frm.CanSave;
  end
  else
  begin
    HTML1.Enabled := False;
    XMP1.Enabled := False;
    Thumbnail1.Enabled := False;
    JpgFromRaw1.Enabled := False;
    Preview1.Enabled := False;
  end;
end;


procedure TfrmNewMain.NewTab(filename: string = '');
var
  aForm: TfrmMain;
  ts: TTabSheet;
begin
  ts := TTabSheet.Create(pc);
  ts.PageControl := pc;

  aForm := TfrmMain.Create(ts);
  aForm.Parent := ts;
  aForm.Align := alClient;
  aForm.BorderStyle := bsNone;
  aForm.Visible := true;
  aForm.TabSheet := ts;
  aForm.html.DefFontSize := ops.FontSize;
  aForm.eSize.Text := IntToStr(ops.FontSize);
  //objlist.AddObject('', aForm);
  objlist.InsertObject(pc.PageCount -1, '', aForm);

  ts.Caption := '-New-';

  pc.ActivePage := ts;
  Application.ProcessMessages;

  if filename <> '' then
    aForm.GetEXIF(FileName);

  HandleChange;
  Open1.Enabled := pc.PageCount > 0;
end;

procedure TfrmNewMain.FormCreate(Sender: TObject);
begin
  ops.SetFormPosition(self);
  
  objlist := TStringList.Create;
  GetFileExts();

  DragAcceptFiles( Handle, True );
end;

procedure TfrmNewMain.GetFileExts;
var
  sl: TStringList;
  s, f: string;
  i: Integer;
begin
  sl := TStringList.Create;
  try
    CaptureConsoleOutput('exiftool -listf', sl);
    //html.LoadStrings(sl, 'none');
    // nef|*.nef|raw|*.raw
    s := sl.Text;
    delete(s, 1, pos(':', s));
    s := Trim(s);
    s := StringReplace(s, #$D#$A+' ', '', [rfReplaceAll]);
    //ShowMessage(s);
    //eFile.Text := s;
    sl.Delimiter := ' ';
    sl.CommaText := s;
    //ListBox1.Items.Assign (sl);// := sl;
    //ShowMessage(sl[0]);
    f := ''; // not the best way to handle this
    //t := '';
    //ShowMessage(inttostr(sl.Count));
    for i := 0 to pred(sl.Count) do
    begin
      //ListBox1.Items.Add(sl[i]);
      //tmp := sl[i] + '|*.' + sl[i] + '|';
      f := f + sl[i] + ' Files|*.' + sl[i] + '|';
      //if i < 42 then
      //t := t + '*.' + sl[i] + ';';
    end;
    //t := t + '*.NEF;';
    //delete(t, length(t), 1);
    //ShowMessage(intTostr(pos(' ', f)));
    //f := 'All|' + t + '|' + f;
    //ShowMessage(intToStr(Length(t)));
    od.Filter := 'All Files (*.*)|*.*|' + f;
    //_filter := f;
  finally
    FreeAndNil(sl);
  end;
end;

procedure TfrmNewMain.Open1Click(Sender: TObject);
begin
  if od.Execute then
  begin
    //NewTab(od.FileName);
//    pc.ActivePage
    GetExif(od.FileName);
  end;
end;

procedure TfrmNewMain.New1Click(Sender: TObject);
begin
  NewTab('');
end;

procedure TfrmNewMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ops.SaveFormPosition(self);
  FreeAndNil(objlist);
end;

procedure TfrmNewMain.FormShow(Sender: TObject);
var
  i: Integer;
begin
  if ParamCount > 0 then
  begin
    for i := 1 to ParamCount do
    begin
      //ShowMessage(ParamStr(i));
      NewTab(ParamStr(i));
    end;
  end
  else
    NewTab('');
end;

procedure TfrmNewMain.GetEXIF(filename: string);
var
  frm: TfrmMain;
begin
  frm := GetActiveForm;
  if Assigned(frm) then
    frm.GetEXIF(filename)
  else
    NewTab(filename);
  HandleChange;
end;

function TfrmNewMain.GetActiveForm:TfrmMain;
var
  idx: Integer;
//  frm: TfrmMain;
begin
  Result := nil;
  idx := pc.ActivePageIndex;
  if idx <> -1 then
    Result := tFrmMain(objlist.Objects[idx]);
end;

procedure TfrmNewMain.AcceptFiles( var msg : TMessage );
var
  i,
  nCount     : integer;
  acFileName : array [0..MAX_PATH] of char;
begin
  // find out how many files we're accepting
  nCount := DragQueryFile( msg.WParam,
                           $FFFFFFFF,
                           acFileName,
                           MAX_PATH );

  // query Windows one at a time for the file name
  for i := 0 to nCount-1 do
  begin
    DragQueryFile( msg.WParam, i,
                   acFileName, MAX_PATH );

    // do your thing with the acFileName
    //MessageBox( Handle, acFileName, '', MB_OK );
    if ops.TabOpt = toCurrent then
      GetExif(acFileName)
    else if ops.TabOpt = toNew then
      NewTab(acFileName);
  end;

  // let Windows know that you're done
  DragFinish( msg.WParam );
end;

procedure TfrmNewMain.Close1Click(Sender: TObject);
begin
  if _idx <> -1 then
  begin
    pc.Pages[_idx].Destroy;
    objlist.Delete(_idx);
  end;

  Open1.Enabled := pc.PageCount > 0;
end;

procedure TfrmNewMain.pcContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  //ShowMessage('yes');
  _idx := pc.IndexOfTabAt(MousePos.X, MousePos.Y);
  //ShowMessage(intTostr(idx));
  Handled := False;
end;

procedure TfrmNewMain.Html1Click(Sender: TObject);
var
  frm: TfrmMain;
begin
  frm := GetActiveForm;
  if Assigned(frm) then
  begin
    sd.DefaultExt := 'html';
    sd.Title := 'Export HTML';
    //sd.FileName := ChangeFileExt(eFile.Text, 'html');
    sd.FileName :=  ChangeFileExt(pc.ActivePage.Caption, '.html');
    sd.Filter := 'HTML Files|*.html;*.htm';
    if sd.Execute then
      frm.SaveHTML(sd.FileName);
  end;
end;

procedure TfrmNewMain.OpenNewTab1Click(Sender: TObject);
begin
  if od.Execute then
  begin
    NewTab(od.FileName);
  end;
end;

procedure TfrmNewMain.XMP1Click(Sender: TObject);
var
  frm: TfrmMain;
begin
  frm := GetActiveForm;
  if Assigned(frm) then
  begin
    sd.DefaultExt := 'xmp';
    sd.FileName :=  ChangeFileExt(pc.ActivePage.Caption, '.xmp');
    sd.Filter := 'XMP Files|*.xmp';
    sd.Title := 'Export XMP';
    if sd.Execute then
      frm.SaveXMP(sd.FileName);
  end;
end;

procedure TfrmNewMain.pcChange(Sender: TObject);
begin
  HandleChange;
end;

procedure TfrmNewMain.Preview1Click(Sender: TObject);
var
  frm: TfrmMain;
  val, meth, msg: string;
begin
  frm := GetActiveForm;
  if Assigned(frm) then
  begin
    val := '';

    case (Sender as TMenuItem).Tag of
      1: begin
        val := '_jfr.jpg';
        meth := 'JpgFromRaw';
        msg := 'JPEG';
      end;
      2: begin
        val := '_preview.jpg';
        meth := 'PreviewImage';
        msg := 'Image Preview';
      end;
      3: begin
        val := '_thumb.jpg';
        meth := 'ThumbnailImage';
        msg := 'Thumbnail';
      end;
    end;

    if val <> '' then
    begin
      if InputQuery('Postfix', 'Append to filename (ex: DSC001.NEF = DSC001'+val+')', val) then
        frm.ExtractData(val, meth, msg);
    end;
   end;
end;

procedure TfrmNewMain.Options1Click(Sender: TObject);
var
  frmOptions: TfrmOptions;
begin
  frmOptions := TfrmOptions.Create(Application);
  try
    frmOptions.ShowModal;
  finally
    FreeAndNil(frmOptions);
  end;
end;

procedure TfrmNewMain.About1Click(Sender: TObject);
begin
  MessageBox(0, 'This is a wrapper for exiftool Copyright 2003-2008, Phil Harvey written by Kenneth Wilcox', 'About', 0); 
end;

procedure TfrmNewMain.IncreaseText1Click(Sender: TObject);
var
  frm: TfrmMain;
  i, c: Integer;
begin
  c := 0;
  for i := 0 to pred(objlist.Count) do
  begin
    frm := TFrmMain(objlist.Objects[i]);
    c := frm.html.DefFontSize + 2;
    if c > 48 then
      c:= 48;
    frm.html.DefFontSize := c;
    frm.Animate1.Visible := False;
    frm.eSize.Text := IntToStr(c);
  end;
  ops.FontSize := c;
end;

procedure TfrmNewMain.DecreaseTextSize1Click(Sender: TObject);
var
  frm: TfrmMain;
  i, c: Integer;
begin
  c := 0;
  for i := 0 to pred(objlist.Count) do
  begin
    frm := TFrmMain(objlist.Objects[i]);
    c := frm.html.DefFontSize - 2;
    if c < 5 then
      c := 6;
    frm.html.DefFontSize := c;
    frm.Animate1.Visible := False;
    frm.eSize.Text := IntToStr(c);
  end;
  ops.FontSize := c;
end;

end.
