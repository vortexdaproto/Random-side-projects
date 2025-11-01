#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#HotkeyInterval 100
#MaxHotkeysPerInterval 200

Time := 100
Button := "Left"
Togglea := false
Location := false

^q::Space

!F7::
Gui, AutoC:New	, -MaximizeBox +AlwaysOnTop								, AutoClicker

Gui, AutoC:Add	, GroupBox		, xm 		ym+10 	Section w200 h50	, Speed:
Gui, AutoC:Add	, Edit			, xs+80 	ys+20			w100 vTime	, %Time%
Gui, AutoC:Add	, Text			, xs+10		ys+22						, Miliseconds:

Gui, AutoC:Add	, GroupBox		, xm		ym+65	Section w200 h80	, Options:
Gui, AutoC:Add	, DropDownList	, xs+50		ys+20	vButton Choose1		, Left|Middle|Right
Gui, AutoC:Add	, Text			, xs+10		ys+22						, Button:
Gui, AutoC:Add	, Checkbox		, xs+10		ys+50	vLocation			, Enable free move

Gui, AutoC:Add	, Button		, xm		ym+165	w80 gButtonOK		, Save
Gui, AutoC:Show	, W300
Return

ButtonOK:
Gui, AutoC:Submit, NoHide
Return

#MaxThreadsPerHotkey 3
F7::
#MaxThreadsPerHotkey 1
CoordMode, mouse, screen
MouseGetPos , X, Y
if Togglea
{
	Togglea := false
	return
}
Togglea := true
if Location
{
	while Togglea
	{
		Click, %Button%
		Sleep, Time
	}
}
else
{
	while Togglea
	{
		Click, %X% %Y% %Button%
		Sleep, Time
	}
}
Return