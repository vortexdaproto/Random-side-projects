#NoEnv
#Warn
#Persistent
Sendmode Input
SetWorkingDir %A_ScriptDir%
Frequency := 500
Length := 1

#q::
	Gui, Sound:New, -MaximizeBox +AlwaysOnTop
	Gui, Sound:Add	, GroupBox		, xm 		ym+10 	Section w200 h70	, Settings:
	Gui, Sound:Add	, Text			, xs+10		ys+22						, Frequency:
	Gui, Sound:Add	, Edit			, xs+80 	ys+20	Number		w100 vFrequency	, %Frequency%
	Gui, Sound:Add	, Text			, xs+10		ys+42						, Length(s):
	Gui, Sound:Add	, Edit			, xs+80 	ys+40	Number		w100 vLength	, %Length%
	Gui, Sound:Add	, Button		, xm		ym+95	w40 gSoundOK		, Play
	Gui, Sound:Show	, W300
return

SoundOK:
	Gui, Sound:Submit, Nohide
	if Length > 10
	{
		MsgBox, Length was too long.
		Return
	}
	Length := (Length*1000)
	SoundBeep, %Frequency%, %Length%
Return
