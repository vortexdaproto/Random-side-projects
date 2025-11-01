; Tree#3533, Language Project - Installer
; Version 1.00

#NoEnv ;Impore preformace by not checking empty variables against env ones.
#SingleInstance Force
SetWorkingDir %A_AppData% ;Sets the main directory to look for files in.
if FIleExist(A_AppData . "\Language-Project-main") ;Make sure it isn't installed.
{
	MsgBox, Heya we noticed this is already installed thanks for trying again. ;Inform the user.
	Return
}
UrlDownloadToFile, https://github.com/Jkblack212/Language-Project/archive/refs/heads/main.zip, %A_AppData%\Language-Project.zip ;Downloads the project
Sleep, 3000 ;Sleep for 3 seconds to allow the files to download.

sZip := A_AppData . "\Language-Project.zip"
sUnz := A_AppData
;The above two lines are input for the code below.
Sleep, 500 ;Sleep.
Unz(sZip,sUnz) ;Run the unzip function.


FileDelete, %A_AppData%\Language-Project.zip ;Deletes the zip file after it is done
FileCreateShortcut, %A_AppData%\Language-Project-main\School project\Language Main.exe, %A_Desktop%\Language Project.lnk, %A_AppData%\Language-Project-main\School project,, Launch the language project, %A_AppData%\Language-Project-main\School project\Data\Icon.ico ;Create a shortcut on the desktop
FileCreateShortcut, %A_AppData%\Language-Project-main\School project, %A_Programs%\Language Project Files.lnk, %A_AppData%\Language-Project-main\School project,, Launch the language project, %A_AppData%\Language-Project-main\School project\Data\Icon.ico ;Create a shortcut in the startmenu
MsgBox, Download Complete ;Give the user information.

;The following function was received from https://www.autohotkey.com/board/topic/60706-native-zip-and-unzip-xpvista7-ahk-l/
Unz(sZip, sUnz)
{
    fso := ComObjCreate("Scripting.FileSystemObject")
    If Not fso.FolderExists(sUnz)
       fso.CreateFolder(sUnz)
    psh  := ComObjCreate("Shell.Application")
    zippedItems := psh.Namespace( sZip ).items().count
	unzippedItems := 0
    psh.Namespace( sUnz ).CopyHere( psh.Namespace( sZip ).items, 4|16 )
    while (zippedItems > unzippedItems) {
        sleep 50
        unzippedItems := psh.Namespace( sUnz ).items().count
        ToolTip Unzipping in progress..
    }
    ToolTip
}