#NoEnv
#Warn
SendMode Input
SetWorkingDir %A_ScriptDir%
Settimer, Rocheck, 5000
Togglea := false
Time := 100
Button := "1"
Location := false
Sides := 2
Rolls := 1
driverchoice := 1
voicechoice := 1
Voice := ComObjCreate("SAPI.SpVoice")

Hotkey, #+m, Main
Hotkey, ^+Del, AutoCMain
Hotkey, +Del, Autoclicker, T3
Hotkey, ^+n, Mouse
Hotkey, ^+q, Toy
Hotkey, #!v, BookMacroExecute
Hotkey, #z, PrioMain

Main:
	curaudioout := Voice.GetAudioOutputs()
	curvoiceout := Voice.GetVoices()
	TTSCombolist := ""
	TTSVoicelist := ""

	Folder := A_AppDataCommon . "\ProtoOS"
	Sound := A_AppDataCommon . "\ProtoOS\Sounds"
	DataFile := A_AppDataCommon . "\ProtoOS\Data.sbd"
	BookFile := A_AppDataCommon . "\ProtoOS\BookMacro.txt"


	For a in curaudioout {
		TTSCombolist .= a.GetDescription . "|"
	}
	For a in curvoiceout {
		TTSVoicelist .= a.GetDescription . "|"
	}

	If !FileExist(Folder){
		FileCreateDir, %Folder%
	} If !FileExist(Sound) {
		FileCreateDir, %Sound%
	} If !FileExist(DataFile) {
		DataFileIn := "Guiwidth:`n360`nGuiheight:`n500`ntabwidth:`n345`ntabheight:`n200`nGapwidth:`n5`nButtonwidth:`n100`nButtonheight:`n20"
		FileAppend, %DataFileIn%, %DataFile%
	} If !FileExist(BookFile) {
		BookFileIn := "Hello World!`nHow are you going today?"
		FileAppend, %BookFileIn%, %BookFile%
	}
	
	try {
		FileReadLine, Hotkey, %DataFile%, 2
		FileReadLine, Guiwidth, %DataFile%, 4
		FileReadLine, Guiheight, %DataFile%, 6
		FileReadLine, Tabwidth, %DataFile%, 8
		FileReadLine, Tabheight, %DataFile%, 10
		FileReadLine, Gapwidth, %DataFile%, 12
		FileReadLine, Buttonwidth, %DataFile%, 14
		FileReadLine, Buttonheight, %DataFile%, 16
		FileRead, FullDataFile, %DataFile%
		FileRead, FullBookFile, %BookFile%
	} catch e {
		MsgBox, There was an error in the DataFile.
		Return
	}

	TabList := "Settings|Main||"
	Gui, proto:New, -MaximizeBox, Protogen.OS
		;testh := Tabheight - 20
		;testw := Tabwidth 
		;Gui, proto:Add, GroupBox, w%testw% h%testh% ym xm
		Gui, proto:Add, Tab3, vOptions Bottom w%Tabwidth% h%Tabheight%, %TabList%
			Gui, proto:Tab, Main
				Gui, proto:Add, GroupBox, x+5 y+5 Section Hidden, Localizer
					Gui, proto:Add, GroupBox, xs ys+5 Section w110 h100, Locations:
						Gui, proto:Add, Link, xs+10 ys+20, <a href="C:\Users\%A_UserName%\OneDrive\Pictures\discord things\chaos">Memes folder</a>
						Gui, proto:Add, Link, xs+10 ys+40, <a href="%A_AppDataCommon%\Info">Info</a>
						Gui, proto:Add, Link, xs+10 ys+60, <a href="C:\Users\%A_UserName%\OneDrive\Documents\Random-side-projects">AHK</a>
						Gui, proto:Add, Link, xs+10 ys+80, <a href="C:\Users\%A_UserName%\OneDrive\Documents\University">University</a>
					Gui, proto:Add, GroupBox, xs+120 ys Section w200 h150, Quick buttons:
						Gui, proto:Add, Button, gAutoCMain xs+10 ys+20, Auto Clicker
						Gui, proto:Add, Button, gDiceMain xs+90 ys+20, Dice
						Gui, proto:Add, Button, gGTNMain xs+10 ys+50, Guess The Number
						Gui, proto:Add, Button, gBookMacroMain xs+120 ys+50, Book Macro
					Gui, proto:Add, GroupBox, xs-120 ys+105 Section h70 w110, TTS
						Gui, proto:Add, Edit, xs+5 ys+15 vTTSOut w100, 
						Gui, proto:Add, Button, default xs+5 ys+40 gText, Playtext

			Gui, proto:Tab, Settings
				EditHeight:= Tabheight - (3*Gapwidth)
				Buttony := Tabheight - 25
				Gui, proto:Add, GroupBox, x+%Gapwidth% y+%Gapwidth% Section w100 h50, Files
					Gui, proto:Add, Link, xs+5 ys+15, <a href="%Sound%">Sounds File</a>
					Gui, proto:Add, Link, xs+5 ys+30, <a href="%DataFile%">Data File</a>
					Gui, proto:Add, Edit, xs+130 ys vDataDisplay w180 h%EditHeight%, %FullDataFile%
					Gui, proto:Add, ComboBox, xs ys+60 w100 vdriverchoice choose%driverchoice% AltSubmit, %TTSCombolist%
					Gui, proto:Add, ComboBox, xs ys+85 w100 vvoicechoice choose%voicechoice% AltSubmit, %TTSVoicelist%
					Gui, proto:Add, Button, xs ys+110 gDriver, Change TTS Settings
					Gui, proto:Add, Button, xs ys+135 gRefresh, Refresh Gui
					
				curx := 0
				cury := 0
				Soundtab := 1
				Loop Files, %Sound%\*.*
				{
					createTab := cury + Buttonheight + (3*Gapwidth) >= (Tabheight - 20 - Buttonheight - (3*Gapwidth)) || Soundtab = 1
					createRow := curx + Buttonwidth + (3*Gapwidth) >= (Tabwidth - 10 - curx)
					
					If (!createTab && !createRow)
						curx := curx + Gapwidth + Buttonwidth
					Else If (!createRow)
					{
						TabList := (Soundtab == 1) ? "|" . TabList . "Sound " . Soundtab : TabList . "|Sound " . Soundtab
						GuiControl, Proto:, Options, %TabList%
						Gui, proto:Tab, Sound %Soundtab%
						Gui, proto:Add, GroupBox, Section Hidden
						Soundtab++
						curx := 0
						cury := 0
					} Else
					{
						cury := cury + Gapwidth + Buttonheight
						curx := 0
					}
						
					SplitPath, A_LoopFileName,,,, Buttontext
					Buttontext := StrReplace(Buttontext, "-", " ")
					Gui, proto:Add, button, xs+%curx% ys+%cury% w%Buttonwidth% h%Buttonheight% v%A_Index%Sound gPlaysound, %Buttontext%
					%A_Index%Sound := A_LoopFilePath
				}
	Gui, proto:Show, w%Guiwidth%
Return

;--------------------------------------------------------------------------------------------------------------------------------

Driver:
	Gui, proto:Submit, Nohide
	For a in curaudioout {
		if (A_Index == driverchoice) {
			Voice.AudioOutput := a
			infoS := a.GetDescription
			Break
		}
	}
	For a in curvoiceout{
		if (A_Index == voicechoice) {
			Voice.Voice := a
			infoV := a.GetDescription
			Break
		}
	}
	MsgBox, TTS output set to: %infoS%`nTTS Voice set to: %infoV%
Return

Text:
	Gui, proto:Submit, Nohide
	try {
		SendInput, {RShift down}
		Voice.Speak(TTSOut)
		SendInput, {RShift up}
	} catch e{
		SendInput, {RShift up}
		MsgBox, Something went worng. Output place change recomened.
	}
Return

Playsound:
	Out := %A_GuiControl%
	try{
		SoundPlay, %Out%
	} catch e{
		Run, %Out%
	}
Return

Refresh:
	Gui, proto:Submit
	FileDelete, %DataFile%
	FileAppend, %DataDisplay%, %DataFile%
	Gosub Driver
	Gosub Main
Return

;--------------------------------------------------------------------------------------------------------------------------------

Mouse:
	CoordMode, mouse, screen
	MouseGetPos , X, Y
	Gui, Mouse:New, -MinimizeBox +AlwaysOnTop, Mouse
		Gui, Mouse:Add, Text,, x=%X% y=%Y%
	Gui, Mouse:Show, W100 NA
Return

MouseGuiClose:
	Gui, Mouse:Destroy
Return

Toy:
	Loop, Read, %A_AppDataCommon%/Info/Toy.txt
		num := A_Index
	Random, Sen, 1, %num%
	FileReadLine, Text, %A_AppDataCommon%\Info\Toy.txt, %Sen%
	SendInput, %Text%
Return

;--------------------------------------------------------------------------------------------------------------------------------

AutoCMain:
	Gui, AutoC:New, -MaximizeBox +AlwaysOnTop, AutoClicker
		Gui, AutoC:Add, GroupBox, xm ym+10 Section w200 h50, Speed:
			Gui, AutoC:Add, Edit, xs+80 ys+20 Number w100 vTime, %Time%
			Gui, AutoC:Add, Text, xs+10 ys+22, Miliseconds:

		Gui, AutoC:Add, GroupBox, xm ym+65 Section w200 h80, Options:
			Gui, AutoC:Add, DropDownList, xs+50	ys+20 AltSubmit vButton Choose%Button%, Left|Middle|Right
			Gui, AutoC:Add, Text, xs+10 ys+22, Button:
			Gui, AutoC:Add, Checkbox, xs+10	ys+50 vLocation Checked%location%, Enable free move

	Gui, AutoC:Add, Button, xm ym+165 w80 gButtonOK, Save
	Gui, AutoC:Show	, W300
Return

ButtonOK:
	Gui, AutoC:Submit, NoHide
Return

AutoCGuiClose:
	Gui, AutoC:Destroy
Return

Autoclicker:
	if Togglea
	{
		Togglea := false
		return
	}
	Togglea := true
	CoordMode, mouse, screen
	MouseGetPos , X, Y
	if Button = 1
		Ainput := "Left"
	if Button = 2
		Ainput := "Middle"
	if Button = 3
		Ainput := "Right"
	while Togglea
	{
		if Location
			Click, %Ainput%
		else
			Click, %X% %Y% %Ainput%
		Sleep, Time
	}
Return

;--------------------------------------------------------------------------------------------------------------------------------

DiceMain:
	Gui, Dice:New, -MaximizeBox +AlwaysOnTop, Dice
		Gui, Dice:Add, GroupBox, xm ym+10 Section w200 h70, Settings:
			Gui, Dice:Add, Edit, xs+80 ys+20 Number w100 vSides, %Sides%
			Gui, Dice:Add, Text, xs+10 ys+22, Sides:
			Gui, Dice:Add, Edit, xs+80 ys+40 Number w100 vRolls, %Rolls%
			Gui, Dice:Add, Text, xs+10 ys+42, Rolls:
		Gui, Dice:Add, Button, xm ym+95 w40 gDiceOK, Save
		Gui, Dice:Add, Button, xm+45 ym+95 w40 gDiceRoll, Roll
	Gui, Dice:Show, W300
Return

DiceOK:
	Gui, Dice:Submit, NoHide
Return

DiceRoll:
	Gui, Dice:Submit, NoHide
	Out := 0
	DiceOutput := ""
	Loop %Rolls%
	{
		Random, Num, 1, %Sides%
		DiceOutput := DiceOutput . Num
		Out += Num
	}
	Gui, DiceOut:New, -MaximizeBox -MinimizeBox +OwnerDice, Dice
	Gui, DiceOut:Add, Text, xm+10 ym+0, %Out%
	DiceOutlen := StrLen(DiceOutput)
	If(DiceOutlen > 43679)
	{
		FileDelete, %A_MyDocuments%\AHK\Diceout.txt
		FileAppend, %DiceOutput%, %A_MyDocuments%\AHK\Diceout.txt
		Gui, DiceOut:Add, Link,, <a href="%A_MyDocuments%\AHK\Diceout.txt">Output</a>
	}
	Else
		Gui, DiceOut:Add, Edit, xm+0 ym+20 w100 r1 ReadOnly, %DiceOutput%
	Gui, DiceOut:Show, w120
Return

DiceGuiClose:
	Gui, Dice:Destroy
Return

;--------------------------------------------------------------------------------------------------------------------------------

GTNMain:
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
	If(GTNG == Num)
	{
		Gui, GTNGAME:Destroy
		Msgbox, Congrats the number was: %Num%`n%Guesses% Guess' Used
	}
	If(GTNG < Num)
		GTNSEN := "Higher"
	If(GTNG > Num)
		GTNSEN := "Lower"
	Guesses++
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

;--------------------------------------------------------------------------------------------------------------------------------

BookMacroMain:
	Gui, Book:New, -MaximizeBox +AlwaysOnTop, Book Macro
		Gui, Book:Add, Text, xm+10 ym+10, Your macro below:
		Gui, Book:Add, Edit, xm+10 ym+30 vBookDisplay w180 h%EditHeight%, %FullBookFile%
		Gui, Book:Add, Button, xm ym+250 w40 gBookMacroOK, Save
	Gui, Book:Show, W300
Return

BookMacroOK:
	Gosub, BookSave
	Gosub, BookMacroMain
Return

BookSave:
	Gui, Book:Submit, NoHide
	FileDelete, %BookFile%
	FileAppend, %BookDisplay%, %BookFile%
	FileRead, FullBookFile, %BookFile%
Return

BookMacroExecute:
	Gosub, BookSave
	Send, %FullBookFile%
Return

;--------------------------------------------------------------------------------------------------------------------------------

PrioMain:
	WinGet, PrioD, PID, A
	WinGetTitle, PrioT, A
	Gui, Prio:New, -MaximizeBox -MinimizeBox +AlwaysOnTop, %PrioT%
		Gui, Prio:Add, DropDownList, vPrioL Choose2, Normal|High|Low|BelowNormal|AboveNormal
		Gui, Prio:Add, Button, default gPrioOk, OK
	Gui, Prio:Show, w200
Return

PrioOk:
	Gui, Prio:Submit
	Gui, Prio:Destroy
	Process, Priority, %PrioD%, %PrioL%
	if ErrorLevel
		MsgBox Success: Its priority was changed to "%PrioL%".
	else
		MsgBox Error: Its priority could not be changed to "%PrioL%".
Return

PrioGuiClose:
	Gui, Prio:Destroy
Return

;--------------------------------------------------------------------------------------------------------------------------------

Rocheck:
	process, exist, Mainr.exe
	if ErrorLevel != 0
		Return
	process, exist, RobloxPlayerBeta.exe
	if ErrorLevel != 0
		Run, %A_MyDocuments%\Random-side-projects\.exe's\Mainr.exe
Return
