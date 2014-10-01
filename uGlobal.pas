unit uGlobal;
// Global object to read, store and write settings
interface

uses
  Forms, SysUtils, Dialogs, IniFiles, uNewMain;

  type
    TTabOptions = (toNew, toCurrent, toNone);

    TOptions = class(TObject)
    private
      tTab: TTabOptions;
      tPos: Boolean;
      tTop: Integer;
      tLeft: Integer;
      tWidth: Integer;
      tHeight: Integer;
      tFontSize: Integer;
      IniName: string;
      constructor Create();
    public
      destructor Destroy(); override;
      property TabOpt: TTabOptions read tTab write tTab;
      property RememberPos: Boolean read tPos write tPos;
      property FontSize: Integer read tFontSize write tFontSize;
      procedure SetFormPosition(var frm: TfrmNewMain);
      procedure SaveFormPosition(frm: TfrmNewMain);
    end;

var ops: TOptions;

implementation

procedure TOptions.SetFormPosition(var frm: TfrmNewMain);
begin
  if tPos then
  begin
    frm.Top := tTop;
    frm.Left := tLeft;
    frm.Height := tHeight;
    frm.Width := tWidth;
  end;
end;

procedure TOptions.SaveFormPosition(frm:TfrmNewMain);
begin
  tTop := frm.Top;
  tLeft := frm.Left;
  tWidth := frm.Width;
  tHeight := frm.Height;
end;

constructor TOptions.Create();
var
  ini: TIniFile;
begin
  inherited Create;
  IniName := ChangeFileExt(Application.ExeName, '.ini');
  ini := TIniFile.Create(IniName);
  try
    tTab := TTabOptions(ini.ReadInteger('KEXIF', 'Tabs', 1));
    tPos := ini.ReadBool('KEXIF', 'Pos', False);
    tFontSize := ini.ReadInteger('KEXIF', 'FS', 10);
    tTop := ini.ReadInteger('POS', 'TOP', -1);
    tWidth := ini.ReadInteger('POS', 'WIDTH', -1);
    tLeft := ini.ReadInteger('POS', 'LEFT', -1);
    tHeight := ini.ReadInteger('POS', 'HEIGHT', -1);

    // Fix users goofing up the ini file
    if (tTop = -1) and (tLeft = -1) and (tWidth = -1) and (tHeight = -1) then
      tPos := False;
    
  finally
    FreeAndNil(ini);
  end;
end;

destructor TOptions.Destroy();
var
  ini: TIniFile;
begin
  // Save the settings
  ini := TIniFile.Create(IniName);
  try
    ini.WriteInteger('KEXIF', 'Tabs', ord(tTab));
    ini.WriteBool('KEXIF', 'Pos', tPos);
    ini.WriteInteger('KEXIF', 'FS', tFontSize);
    ini.WriteInteger('POS', 'TOP', tTop);
    ini.WriteInteger('POS', 'WIDTH', tWidth);
    ini.WriteInteger('POS', 'LEFT', tLeft);
    ini.WriteInteger('POS', 'HEIGHT', tHeight);

  finally
    FreeAndNil(ini);
  end;

  inherited Destroy;
end;

initialization
  ops := TOptions.Create;

finalization
  ops.Free;

end.
