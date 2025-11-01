#NoEnv
#Warn
#Persistent
Sendmode Input
SetWorkingDir %A_ScriptDir%

Folder := A_Programs . "\SoundBoard"
If !FileExist(Folder){
	FileCreateDir, %Folder%
} If !FileExist(Folder . "\Sounds") {
	FileCreateDir, %Folder%\Sounds
} If !FileExist(Folder . "\Data.sbd") {
	DataFileIn := "Guiwidth:`n360`nGuiheight:`n500`ntabwidth:`n345`ntabheight:`n200`nGapwidth:`n5`nButtonwidth:`n100`nButtonheight:`n20"
	FileAppend, %DataFileIn%, %Folder%\Data.sbd
}

Sound := Folder . "\Sounds"
DataFile := Folder . "\Data.sbd"
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
} catch e {
	MsgBox, There was an error in the DataFile.
	Return
}
Hotkey, %Hotkey%, Main

Main:
curx := 0
cury := 0
Soundtab := 1
SoundTabList := "Settings|Sound " . Soundtab . "||"
Gui, Soundb:New, -MaximizeBox, Testing dumb stuff
	Gui, Soundb:Add, Tab3, LEFT w%Tabwidth% h%Tabheight% vOptions, %SoundTabList%
		Gui, Soundb:Tab, Sound %Soundtab%
			Gui, Soundb:Add, GroupBox, x+5 y+5 Section Hidden, Buttons
				Loop Files, %Sound%\*.*
				{
					If (cury + (2*Gapwidth) + Buttonheight >= Tabheight) {
						If (Soundtab == 1)
							SoundTabList := "|" . SoundTabList
						Soundtab++
						SoundTabList := SoundTabList . "Sound " . Soundtab . "|"
						GuiControl,, Options, %SoundTabList%
						Gui, Soundb:Tab, Sound %Soundtab%
						Gui, Soundb:Add, GroupBox, x+5 y+5 Section w100 h60 Hidden, Buttons
						curx := 0
						cury := 0	
					}
					If (curx + (2*Gapwidth) + Buttonwidth > Tabwidth - curx) {
						cury := cury + Gapwidth + Buttonheight
						curx := 0
					} Else If (A_Index == 1) {
					} Else {
						curx := curx + Gapwidth + Buttonwidth
					}
					Buttontext := StrReplace(StrReplace(A_LoopFileName, "." . A_LoopFileExt), "-", A_space)
					Gui, Soundb:Add, button, xs+%curx% ys+%cury% w%Buttonwidth% h%Buttonheight% v%A_Index%Sound gPlaysound, %Buttontext%
					%A_Index%Sound := A_LoopFilePath
					
				}
			
		Gui, Soundb:Tab, Settings
			EditHeight:= Tabheight - (3*Gapwidth)
			Buttony := Tabheight - 25
			Gui, Soundb:Add, GroupBox, x+%Gapwidth% y+%Gapwidth% Section w100 h50, Files
				Gui, Soundb:Add, Link, xs+5 ys+15, <a href="%Sound%">Sounds File</a>
				Gui, Soundb:Add, Link, xs+5 ys+30, <a href="%DataFile%">Data File</a>
				Gui, Soundb:Add, Edit, xs+110 ys vDataDisplay h%EditHeight%, %FullDataFile%			
				
			Gui, Soundb:Add, Button, xs y%Buttony% gRefresh, Refresh Gui
Gui, Soundb:Show, w%Guiwidth% h%Guiheight%
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
	Gui, Soundb:Submit
	FileDelete, %DataFile%
	FileAppend, %DataDisplay%, %DataFile%
	
	Reload
Return