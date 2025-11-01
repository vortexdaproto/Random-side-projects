#NoEnv
#Warn
SendMode Input
SetWorkingDir %A_ScriptDir%
Settimer, updateTime, 500, 10
OnExit("DuringExit")
Folder := A_AppDataCommon . "\Quests"
If !FileExist(Folder){
    FileCreateDir, %Folder%
}

Hotkey, #a, Startcount

QuestMain:
    SplitPath, A_ScriptFullPath,,,, GuiName
    UPTI := "  win + a to start  "
	Gui, Quest:New, -MaximizeBox, %GuiName%
		Gui, Quest:Add, GroupBox, xm ym+35 Section w300 h50, Name of App:
			Gui, Quest:Add, Edit, vQuestName xs+80 ys+20 w180
			Gui, Quest:Add, Text, xs+10 ys+22, Quest Name:
        Gui, Quest:Add, Text, xm ym+10, Timer:
        Gui, Quest:Add, Edit, vUPTI xm+35 yp-5 ReadOnly, %UPTI%
		Gui, Quest:Add, Button, xm ym+95 w40 Default gQuestGo, Go
        Gui, Quest:Add, Button, xm+60 ym+95 w40 gQuestExit, Exit
	Gui, Quest:Show, W300
Return

QuestGo:
    Gui, Quest:Submit, NoHide
    try {
        SplitPath, A_ScriptFullPath,,, OutExtension
        FileCopy, %A_ScriptFullPath%, %Folder%/%QuestName%.%OutExtension%, 1
        Run, %Folder%/%QuestName%.%OutExtension%
        Sleep, 300
    } Catch {
        MsgBox,, Error, A file name cannot contain the following`n \ / : * ? " < > |, 10
        Return
    }

QuestGuiClose:
QuestExit:
    ExitApp
Return

updateTime:
    if (A_TimeSinceThisHotkey < 0) {
        seconds := "win + a to start  "
        minutes := ""
        hours := ""
        Settimer, updateTime, Off
    } else {
        time := A_TimeSinceThisHotkey
        seconds := floor(Mod(time / 1000, 60)) . "s"
        minutes := floor(Mod(time / 1000 / 60, 60)) . "m"
        hours := floor(time / 1000 / 60 / 60) . "h"
    }
    GuiControl, Quest:, UPTI, %hours% %minutes% %seconds%
Return

Startcount:
    Settimer, updateTime, On
Return

DuringExit(ExitReason, ExitCode) {
    folderE := A_AppDataCommon . "\Quests"
    If FileExist(folderE) {
        FileRemoveDir, %folderE%, 1
    }
}
