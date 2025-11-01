#NoEnv
#warn
SendMode Input
SetWorkingDir %A_ScriptDir%

if !FileExist("C:\ProgramData\Birthday.jpg")
	UrlDownloadToFile, https://getwallpapers.com/wallpaper/full/2/0/4/305724.jpg, C:\ProgramData\Birthday.jpg
if !FileExist("C:\ProgramData\Buttons.png")
	UrlDownloadToFile, https://i.imgur.com/9THKGSn.png, C:\ProgramData\Buttons.png
	
Gui, Present:New, -MinimizeBox -MaximizeBox +AlwaysOnTop, Happy Birthday
Gui, Present:Add, Text,, Happy birthday mum, love you very much and hope you have a great day.
Gui, Present:Add, Text,, - James
Gui, Present:Add, Picture, w650 h325, C:\ProgramData\Birthday.jpg
Gui, Present:Add, Button, gInfoCard, Continue
Gui, Present:Show
Return

InfoCard:
	Gui, Present:Destroy
	Gui, Info:New, -MinimizeBox -MaximizeBox +AlwaysOnTop, Happy Birthday
	Gui, Info:Add, Text,, This program will let you change how much of the computer other programs get to use by pressing the windows key and then z.
	Gui, Info:Add, Text,, Feel free to ask if you need more help to use it.
	Gui, Info:Add, Picture, w650 h200, C:\ProgramData\Buttons.png
	Gui, Info:Add, Button, gInfoGuiClose, Finish
	Gui, Info:Show
Return

PresentGuiEscape:
PresentGuiClose:
	Gui, Present:Destroy
Return

InfoGuiEscape:
InfoGuiClose:
	Gui, Info:Destroy
Return

;--------------------------------------------------------------------------------------------------------------------------------

#z::
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

PrioGuiEscape:
PrioGuiClose:
	Gui, Prio:Destroy
Return
