#NoEnv
#Warn
#Hotstring NoMouse
SendMode Input
SetWorkingDir %A_ScriptDir%

VM3 := InputHook("V", "/")
VM3.EndKey := Countik
VM3.OnEnd := Func("VM3F")
VM3.Start()
VM3F(hook)
{
	Global Countdb
	Global Countdt
	if hook.EndKey == "/"
	{
		VM31 := InputHook("V", "{Enter}")
		VM31.KeyOpt("{Enter}", "S+")
		VM31.Start()
		VM31.Wait()
		Len := StrLen(VM31.Input)
		SendInput, ^a
		SendInput, {_ %Len%}
		Sleep, 100
		SendInput {Enter}
	}
	hook.Start()
}

