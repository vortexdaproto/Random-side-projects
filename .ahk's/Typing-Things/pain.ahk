#NoEnv
#Warn
SendMode Input
SetWorkingDir %A_ScriptDir%

w::s
s::w
a::d
d::a

!Esc::
MsgBox, 4, Stop the script "pain"
IfMsgBox, No
	return
exitapp
