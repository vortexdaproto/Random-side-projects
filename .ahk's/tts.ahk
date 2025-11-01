#NoEnv
#Persistent
Sendmode Input
SetWorkingDir %A_ScriptDir%
Togglea := false
Time := 100
Button := "1"
Location := false
driverchoice := 1
voicechoice := 1
Voice := ComObjCreate("SAPI.SpVoice")

Main:
	curaudioout := Voice.GetAudioOutputs()
	curvoiceout := Voice.GetVoices()
	TTSCombolist := ""
	TTSVoicelist := ""
	For a in curaudioout {
		TTSCombolist .= a.GetDescription . "|"
	}
	For a in curvoiceout {
		TTSVoicelist .= a.GetDescription . "|"
	}

	Folder := A_Programs . "\TTS by Tree"
	If !FileExist(Folder){
		FileCreateDir, %Folder%
	} If !FileExist(Folder . "\TTS.sbd") {
		DataFileIn := "Menu HotKey`n^+m`nAutoClicker Menu key`n^+n`nAutoClicker Enable/Disable`nF6"
		FileAppend, %DataFileIn%, %Folder%\TTS.sbd
	}
	
	DataFile := Folder . "\TTS.sbd"
	try {
		FileReadLine, MenuKey, %DataFile%, 2
		FileReadLine, AutoClickerSettings, %DataFile%, 4
		FileReadLine, AutoClickerEnable, %DataFile%, 6
	} catch e {
		MsgBox, There was an error in the DataFile. Delete %DataFile% to repair.
		ExitApp
	}
	
	Hotkey, %MenuKey%, Main
	Hotkey, %AutoClickerSettings%, AutoCMain
	Hotkey, %AutoClickerEnable%, Autoclicker, T3
	
	Gui, TTS:New, -MaximizeBox, TTS thing by Tree
		Gui, TTS:Add, GroupBox, xm ym Section w90 h40, Quick buttons:
			Gui, TTS:Add, Button, gAutoCMain xs+10 ys+15, Auto Clicker
		Gui, TTS:Add, GroupBox, xm ym+50 Section h70 w110, TTS
			Gui, TTS:Add, Edit, xs+5 ys+15 vTTSOut w100, 
			Gui, TTS:Add, Button, default xs+5 ys+40 gText, Playtext

		Gui, TTS:Add, GroupBox, xm+130 ym Section w100 h35, Files
			Gui, TTS:Add, Link, xs+5 ys+15, <a href="%DataFile%">Data File</a>
			Gui, TTS:Add, ComboBox, xs ys+45 w100 vdriverchoice choose%driverchoice% AltSubmit, %TTSCombolist%
			Gui, TTS:Add, ComboBox, xs ys+70 w100 vvoicechoice choose%voicechoice% AltSubmit, %TTSVoicelist%
			Gui, TTS:Add, Button, xs ys+95 gDriver, Change TTS Settings

	Gui, TTS:Show

Return

Driver:
	Gui, TTS:Submit, Nohide
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
	Gui, TTS:Submit, Nohide
	try {
		Voice.Speak(TTSOut)
	} catch e{
		MsgBox, Something went worng. Output place change recomened.
	}
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