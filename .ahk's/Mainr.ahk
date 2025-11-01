#NoEnv
#Warn
SendMode Input
SetWorkingDir %A_ScriptDir%
Settimer, Rocheck, 5000
MuteSI := "Text on visor"
Power := 0

;--------------------------------------------------------------------------------------------------------------------------------
^r::
	SendInput, {Esc}{Sleep 400}r{Sleep 100}{Enter}
Return

!1::
	SendInput, - %MuteSI%:{space}
Return

^!1::
	Gui, MuteS:New, -MinimizeBox -MaximizeBox +AlwaysOnTop, Mute Speech
	Gui, MuteS:Add, DropDownList, xm ym+10 vMuteSI Choose1, Text on visor|NZSL|Writes|Types
	Gui, MuteS:Add, Button, xm+125 ym+9 gMuteSOK, Save
	Gui, MuteS:Show, W175
Return

MuteSOK:
	Gui, MuteS:Submit
	Gui, MuteS:Destroy
Return

MuteSGuiClose:
	Gui, MuteS:Destroy
Return

#q::
	Reload
Return

;--------------------------------------------------------------------------------------------------------------------------------

^+j::
	Countdr := 300
	Countdt := 60
	Counti := InputHook("V", "/")
	Countir := Counti.Endreason
	Counti.OnEnd := Func("Counttc")
	Gui, Countd:New, -MaximizeBox -MinimizeBox +AlwaysOnTop, Countd
	Gui, Countd:Add, GroupBox, xm ym+10 Section w100 h50, Talk Start:
	Gui, Countd:Add, Edit, xs+10 ys+20 w30 Number vCountdt , %Countdt%
	Gui, Countd:Add, Button, xs+50 ys+20 gCountts, Start
	Gui, Countd:Add, GroupBox, xm+110 ym+10 Section w100 h50, Reward Start:
	Gui, Countd:Add, Edit, xs+10 ys+20 w30 Number vCountdr, %Countdr%
	Gui, Countd:Add, Button, xs+50 ys+20 gCountrs, Start
	Gui, Countd:Add, Button, xm ym+70 gCountc, Cancel
	Gui, Countd:Show, W250 NA
Return

Countrs:
	Gui, Countd:submit
	Gui, Countd:New, -MaximizeBox -MinimizeBox +AlwaysOnTop, Countdr
	Gui, Countd:Add, Edit, xm ym vCountdr ReadOnly, %Countdr%
	Gui, Countd:Add, Button, xm+40 ym gCountc, Cancel
	Gui, Countd:Show, X924 Y24 W100 NA
	while Countdr > 0 
	{
		Countdr -= 1
		GuiControl,, Countdr, %Countdr%
		Sleep, 1000
	}
Goto Counttu

Countts:
	Gui, Countd:submit
	Countds := Countdt
	Gui, Countd:New, -MaximizeBox -MinimizeBox +AlwaysOnTop, Countdt
	Gui, Countd:Add, Edit, xm ym vCountdt ReadOnly, %Countdt%
	Gui, Countd:Add, Button, xm+40 ym gCountc, Cancel
	Gui, Countd:Show, X924 Y24 W100 NA
	Counti.Start()
	while Countdt > 0 
	{
		Countdt -= 1
		GuiControl,, Countdt, %Countdt%
		Sleep, 1000
	}
Goto Counttu

Counttc(Hook)
{
	If Hook.Endreason == "Stopped"
		Return
	Countic := InputHook("V", "{Enter}")
	Countic.KeyOpt("{Enter}", "S+")
	Countic.Start()
	Countic.Wait()
	Global Countds
	Global Countdt
	Countil := StrLen(Countic.Input)
	If (Countil > 0)
	{
		Countdt := Countds
	}
	SendInput, {Enter}
	Hook.Start()
}

Counttu:
	Gui, Counttu:New, -MaximizeBox -MinimizeBox +AlwaysOnTop, Countde
	Gui, Counttu:Add, Text,, Time up
	Gui, Counttu:Show, w100

CountdGuiClose:
Countc:
	Gui, Countd:Destroy
	Counti.Stop()
	Countds := ""
	Countdr := 0
	Countdt := 0
Return

CounttuGuiClose:
	Gui, Counttu:Destroy
Return

;--------------------------------------------------------------------------------------------------------------------------------

Rocheck:
	process, exist, RobloxPlayerBeta.exe
	if ErrorLevel = 0
		ExitApp
Return