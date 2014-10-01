unit uConsole;

interface

uses
  Windows, SysUtils, Classes, Forms;

procedure CaptureConsoleOutput(DosApp : string;AMemo : TStringList);

implementation

// http://www.delphi3000.com/articles/article_3361.asp
procedure CaptureConsoleOutput(DosApp : string;AMemo : TStringList);
const
  ReadBuffer = 1048576;  // 1 MB Buffer
  //ReadBuffer = 1048;  // 1 MB Buffer
var
  Security            : TSecurityAttributes;
  ReadPipe,WritePipe  : THandle;
  start               : TStartUpInfo;
  ProcessInfo         : TProcessInformation;
  Buffer              : Pchar;
  TotalBytesRead,
  BytesRead           : DWORD;
  Apprunning,n,
  BytesLeftThisMessage,
  TotalBytesAvail : integer;
begin
  with Security do
  begin
    nlength              := SizeOf(TSecurityAttributes);
    binherithandle       := true;
    lpsecuritydescriptor := nil;
  end;

  if CreatePipe (ReadPipe, WritePipe, @Security, 0) then
  begin
    // Redirect In- and Output through STARTUPINFO structure

    Buffer  := AllocMem(ReadBuffer + 1);
    FillChar(Start,Sizeof(Start),#0); 
    start.cb          := SizeOf(start); 
    start.hStdOutput  := WritePipe; 
    start.hStdInput   := ReadPipe; 
    start.dwFlags     := STARTF_USESTDHANDLES + STARTF_USESHOWWINDOW; 
    start.wShowWindow := SW_HIDE; 

    // Create a Console Child Process with redirected input and output 

    if CreateProcess(nil      ,PChar(DosApp), 
                     @Security,@Security, 
                     true     ,CREATE_NO_WINDOW or NORMAL_PRIORITY_CLASS, 
                     nil      ,nil, 
                     start    ,ProcessInfo) then 
    begin 
      n:=0; 
      TotalBytesRead:=0; 
      repeat 
        // Increase counter to prevent an endless loop if the process is dead 
        Inc(n,1); 
         
        // wait for end of child process 
        Apprunning := WaitForSingleObject(ProcessInfo.hProcess,100); 
        Application.ProcessMessages;

        // it is important to read from time to time the output information 
        // so that the pipe is not blocked by an overflow. New information 
        // can be written from the console app to the pipe only if there is 
        // enough buffer space. 

        if not PeekNamedPipe(ReadPipe        ,@Buffer[TotalBytesRead], 
                             ReadBuffer      ,@BytesRead, 
                             @TotalBytesAvail,@BytesLeftThisMessage) then break 
        else if BytesRead > 0 then 
          ReadFile(ReadPipe,Buffer[TotalBytesRead],BytesRead,BytesRead,nil); 
        TotalBytesRead:=TotalBytesRead+BytesRead; 
      until (Apprunning <> WAIT_TIMEOUT) or (n > 150); 

      Buffer[TotalBytesRead]:= #0; 
      OemToChar(Buffer,Buffer);
      AMemo.Text := AMemo.text + StrPas(Buffer);
    end; 
    FreeMem(Buffer); 
    CloseHandle(ProcessInfo.hProcess); 
    CloseHandle(ProcessInfo.hThread); 
    CloseHandle(ReadPipe); 
    CloseHandle(WritePipe); 
  end; 
end;

end.
