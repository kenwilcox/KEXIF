# I guess these are golbals
!include "MUI.nsh"
BrandingText "Ken's Install"
Name "KEXIF"
OutFile "kexif-0.1.exe"
InstallDir "$PROGRAMFILES\KEXIF"
InstallDirRegKey HKCU "Software\KEXIF" ""
RequestExecutionLevel admin

  Var MUI_TEMP
  Var STARTMENU_FOLDER

!define MUI_ABORTWARNING

;PAGES
!insertmacro MUI_PAGE_LICENSE "test.txt"
#!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY

; Start Menu Folder Page Configuration
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU" 
!define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\KEXIF" 
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Start Menu Folder"
!insertmacro MUI_PAGE_STARTMENU Application $STARTMENU_FOLDER

!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_LANGUAGE "English"

#Section "KEXIF" SecKEXIF
Section
  SetOutPath "$INSTDIR"
  file KEXIF.exe
  file exiftool.exe
  #file test.txt
  ; Store Installation folder
  WriteRegStr HKCU "Software\KEXIF" "" $INSTDIR
  ; Create an Uninstaller
  WriteUninstaller $INSTDIR\unkexif.exe
  
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    CreateDirectory "$SMPROGRAMS\$STARTMENU_FOLDER"
    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\KEXIF.lnk" "$INSTDIR\KEXIF.exe"
    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Uninstall KEXIF.lnk" "$INSTDIR\unkexif.exe"
  !insertmacro MUI_STARTMENU_WRITE_END
SectionEnd

#LangString DESC_KEXIF ${LANG_ENGLISH} "Installs KEXIF and necessary support files."
#!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
#  !insertmacro MUI_DESCRIPTION_TEXT ${SecKEXIF} $(DESC_KEXIF)
#!insertmacro MUI_FUNCTION_DESCRIPTION_END

Section "Uninstall"
  Delete $INSTDIR\test.txt
  Delete $INSTDIR\exiftool.exe
  Delete $INSTDIR\KEXIF.exe
  Delete $INSTDIR\KEXIF.ini
  Delete $INSTDIR\unkexif.exe
  RMDir "$INSTDIR"
  
  !insertmacro MUI_STARTMENU_GETFOLDER Application $MUI_TEMP
    
  Delete "$SMPROGRAMS\$MUI_TEMP\Uninstall KEXIF.lnk"
  Delete "$SMPROGRAMS\$MUI_TEMP\KEXIF.lnk"
  
  ;Delete empty start menu parent diretories
  StrCpy $MUI_TEMP "$SMPROGRAMS\$MUI_TEMP"
 
  ; I don't know what the heck this does, but I don't know if it does anything 
  startMenuDeleteLoop:
	ClearErrors
    RMDir $MUI_TEMP
    GetFullPathName $MUI_TEMP "$MUI_TEMP\.."
    
    IfErrors startMenuDeleteLoopDone
  
    StrCmp $MUI_TEMP $SMPROGRAMS startMenuDeleteLoopDone startMenuDeleteLoop
  startMenuDeleteLoopDone:

  DeleteRegKey /ifempty HKCU "Software\KEXIF"
  
SectionEnd