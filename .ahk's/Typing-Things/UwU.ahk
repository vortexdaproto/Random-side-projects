#NoEnv
#Warn
#Hotstring NoMouse
SendMode Input
SetWorkingDir %A_ScriptDir%

r::w
l::w

!Esc::
MsgBox, 4, Stop the script "UwU"
IfMsgBox, No
	return
exitapp