#NoEnv
#warn
SendMode Input
SetWorkingDir %A_ScriptDir%
Toggle := false

^+g::
Num := 0
if Toggle
	{
		Toggle := false
		Return
	}
Toggle := true
while Toggle
{
	SendInput, %Num%{Enter}
	Num += 1
	Sleep, 10000
}
Return