; Made By vortexdaproto On Discord.
; For 576617312308953106

#NoEnv
#Warn
SendMode Input
SetWorkingDir %A_ScriptDir%
OnExit("DuringExit")

Folder := A_AppDataCommon . "\puppypoints"
userFile := A_AppDataCommon . "\puppypoints\users.csv"
dataFile := A_AppDataCommon . "\puppypoints\data.txt"

If !FileExist(Folder) {
    FileCreateDir, %Folder%
} If !FileExist(userFile) {
    FileAppend,, %userFile%
} If !FileExist(dataFile) {
    dataIn := "#Hotkey modifiers are: ^ For Ctrl, + for Shift, # for win, ! for alt`n#Hotkey:^1`n`n#Can replace 'placeholder' with anything. And can replace 'link' with any link or file path`nplaceholder:link`nplaceholder:link`nplaceholder:link`nplaceholder:link`nplaceholder:link`nplaceholder:link`n`n#Delete this file to go back to defaults"
    FileAppend, %dataIn%, %dataFile%
}

main:
    userArray := {}
    dataArray := {}
    SLUserName := 1
    SLUserValue := 0
    SLOption := 1
    ADUserName := ""
    ADUserValue := ""
    userList := ""

    csvArray := []
    Loop Read, %userFile% 
    {
        try {
            if(StrLen(A_LoopReadLine) > 0) {
                csvArray := StrSplit(A_LoopReadLine, ":")
                userArray[csvArray[1]] := csvArray[2]
                userList .= csvArray[1] . "|"
            }
        } catch e {
            MsgBox, There is an error in the UserFile.
        }
    }

    Loop Read, %dataFile%
    {
        try {
            if(StrLen(A_LoopReadLine) > 0 && !InStr(A_LoopReadLine, "#")) {
                csvArray := StrSplit(A_LoopReadLine, ":")
                dataArray[csvArray[1]] := csvArray[2]
            } Else If(InStr(A_LoopReadLine, "#Hotkey")) {
                mainKey := StrSplit(A_LoopReadLine, ":")[2]
            }
        } catch e {
            MsgBox, There is an error in the dataFile.
        }
    }
    Hotkey, %mainKey%, main

    Gui, Points:New, -MaximizeBox, Puppy Points
        Gui, Points:Add, GroupBox, xm+5 ym+5 h70 w200 Section, Point Controller
            Gui, Points:Add, ComboBox, vSLUserName xs+5 ys+15 w100 choose%SLUserName%, %userList%
            Gui, Points:Add, DropDownList, vSLOption AltSubmit xs+114 ys+15 w30 choose1, +|-
            Gui, Points:Add, Edit, vSLUserValue xs+145 ys+15 h19 w50 Number
            Gui, Points:Add, Text, xs+109 ys+18, :
            Gui, Points:Add, Text, xs+145 ys+40, Number of`npoints
            Gui, Points:Add, Button, gPointsAccept xs+5 ys+40, Save Points
        Gui, Points:Add, GroupBox, xm+5 ym+105 h71 w200 Section, Add New User
            Gui, Points:Add, Edit, vADUserName xs+5 ys+15 w100 h19
            Gui, Points:Add, Edit, vADUserValue xs+115 ys+15 w50 h19 Number
            Gui, Points:Add, Text, xs+109 ys+18, :
            Gui, Points:Add, Text, xs+115 ys+40, Number of`npoints
            Gui, Points:Add, Button, gPointsAddUser xs+5 ys+40, Add User
        Gui, Points:Add, GroupBox, xm+210 ym+5 h171 w110 Section, Settings
            Gui, Points:Add, Link, xs+5 ys+15, <a href="%Folder%">Save Location</a>
            y := 30
            For K, V in dataArray {
                Gui, Points:Add, Link, xs+5 ys+%y%, <a href="%V%">%K%</a>
                y += 15
            }
            Gui, Points:Add, Button, gGuessTheNumber xs+5 ys+120, Guess The Number
            Gui, Points:Add, Button, gReloadGui xs+5 ys+145, Reload
    Gui, Points:Show, w350
Return

PointsAccept:
    Gui, Points:Submit, NoHide
    If (userArray.HasKey(SLUserName) && SLUserValue > 0)
    {
        try {
            If (SLOption == 1) 
                userArray[SLUserName] += SLUserValue
            Else If (SLOption == 2)
                userArray[SLUserName] -= SLUserValue
            out := SLUserName . ":" . userArray[SLUserName]
            MsgBox, %out%
            DuringExit("New Points", 0)
        } catch {
            MsgBox, Something went wrong when adding/subtracting points
        }
    } Else {
        MsgBox, A user didn't exist, or you didn't provide a number.
    }
Return

PointsAddUser:
ReloadGui:
	Gui, Points:Submit
    if (StrLen(ADUserName) > 0 && StrLen(ADUserValue) > 0) {
        try {
            userArray[ADUserName] := ADUserValue
            out := ADUserName . ":" . ADUserValue
            MsgBox, %out%
        } catch {
            MsgBox, Something went wrong with uploading a new user
        }
    }
	DuringExit("Reloading", 0)
	Gosub Main
Return

PointsGuiClose:
    DuringExit("Gui Closed", 0)
    Gui, Points:Destroy
Return

DuringExit(ExitReason, ExitCode) {
    global userArray
    global userFile

    FileDelete, %userFile%
    For Key, Value in userArray {
        s := Key . ":" . Value . "`n"
        FileAppend, %s%, %userFile%
    }
}


;-- Guess the number Code -----------------------------------------------------------------------------------------------------------

; Made By vortexdaproto On Discord.

GuessTheNumber:
Guesses := 0

Gui, GTN:New, -MaximizeBox -MinimizeBox +AlwaysOnTop, Guess The Number
Gui, GTN:Add, DropDownList, vGTNO Choose2 AltSubmit, Easy|Normal|Hard|Extra Hard|Extreme|Plausible
Gui, GTN:Add, Button, default gGTNOKS, OK
Gui, GTN:Show, w200
Return

GTNOKS:
	Gui, GTN:Submit
	Gui, GTN:Destroy
	GTNIn := (1*10**GTNO)
	Random, Num, 1, %GTNIn%
	GTNHL := "No Guess"
	Gui, GTNGAME:New, -MaximizeBox -MinimizeBox +AlwaysOnTop, Guess The Number
	If(GTNO != 6)
		Gui, GTNGAME:Add, Edit, vGTNHL xm ym w60 ReadOnly, %GTNHL%
	Gui, GTNGAME:Add, Edit, vGTNG xm ym+30 w100 Number
	Gui, GTNGAME:Add, Button, default gGTNG xm ym+60, OK
	Gui, GTNGAME:Add, Button, -default gGTNQ xm+40 ym+60, Quit
	Gui, GTNGAME:Add, Text, xm+70 ym+5, 1 - %GTNIn%
	Gui, GTNGAME:Show, w200
Return

GTNG:
	Gui, GTNGAME:Submit, NoHide
    Guesses++
	If(GTNG == Num)
	{
		Gui, GTNGAME:Destroy
		Msgbox, Congrats the number was: %Num%`n%Guesses% Guess' Used
	}
	If(GTNG < Num)
		GTNSEN := "Higher"
	If(GTNG > Num)
		GTNSEN := "Lower"
	GuiControl,, GTNHL, %GTNSEN%
	GuiControl,, GTNG,
Return

GTNQ:
GTNGAMEGuiClose:
	Gui, GTNGAME:Destroy
	Msgbox, Cya btw the number was: %Num%`n%Guesses% Guess' Used
Return

GTNGuiClose:
	Gui, GTN:Destroy
Return