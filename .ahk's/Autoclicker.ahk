#NoEnv
#Warn
SendMode Input
SetWorkingDir %A_ScriptDir%

AutoclickTogglea := false
AutoclickTime := 100
AutoclickButton := "Left"
AutoclickButtonOption := "1"
AutoclickType := "AutoCSingle"

Location := false

Hotkey, ^+Del, AutoCMain
Hotkey, +Del, %AutoclickType%, T3

AutoCMain:
	Gui, AutoC:New, -MaximizeBox +AlwaysOnTop, AutoClicker
		Gui, AutoC:Add, Tab3, LEFT w300 vOptions, Single|Multi
			Gui, AutoC:Tab, Single
				Gui, AutoC:Add, GroupBox, y+10 Section w200 h50, Speed:
					Gui, AutoC:Add, Edit, xs+80 ys+20 Number w100 vAutoclickTime, %AutoclickTime%
					Gui, AutoC:Add, Text, xs+10 ys+22, Miliseconds:

				Gui, AutoC:Add, GroupBox, xs ys+55 Section w200 h80, Options:
					Gui, AutoC:Add, DropDownList, xs+50	ys+20 vAutoclickButton Choose%AutoclickButtonOption%, Left|Right|Middle
					Gui, AutoC:Add, Text, xs+10 ys+22, Button:
					Gui, AutoC:Add, Checkbox, xs+10	ys+50 vLocation Checked%location%, Enable free move

				Gui, AutoC:Add, Button, xs ys+90 w80 gAutoCButtonOK, Save
			
			Gui, AutoC:Tab, Multi
				Gui, AutoC:Add, GroupBox, y+10 Section w250 h125, Nuclear weapon.
					Gui, AutoC:Add, ListView, -ReadOnly NoSortHdr Grid Checked xs+5 ys+15 w240 h100, Sleep(ms)|X pos|Y Pos|Button
					LV_Add(, 1000, 500, 500, "Middle")
					
				Gui, AutoC:Add, Button, xs ys+135 w80 gAutoCButtonOK, Save

	Gui, AutoC:Show
Return

AutoCButtonOK:
	Gui, AutoC:Submit, NoHide
	AutoClickButtonOption := StrLen(AutoclickButton) - 3
Return

AutoCGuiClose:
	Gui, AutoC:Destroy
Return

AutoCSingle:
	if AutoclickTogglea
	{
		AutoclickTogglea := false
		return
	}
	AutoclickTogglea := true
	CoordMode, mouse, screen
	MouseGetPos , X, Y
	while AutoclickTogglea
	{
		if Location
			Click, %AutoclickButton%
		else
			Click, %X% %Y% %AutoclickButton%
		Sleep, AutoclickTime
	}
Return