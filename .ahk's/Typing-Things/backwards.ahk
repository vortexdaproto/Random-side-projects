#NoEnv
#Warn
Sendmode Input
SetWorkingDir %A_ScriptDir%

out := ""
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
		SendInput, {BS}
		Global out
		VM31 := InputHook("V", "{Enter}")
		VM31.KeyOpt("{Enter}", "S+")
		VM31.OnEnd := Func("Flip")
		VM31.Start()
		VM31.Wait()
		SendInput, ^a
		SendInput, %out%
		Sleep, 100
		SendInput {Enter}
	}
	hook.Start()
	out := ""
}

Flip(hook) {
	Global out
    n := StrLen(hook.input)
    Loop %n%
        out .= SubStr(hook.input, n--, 1)
    return out
}