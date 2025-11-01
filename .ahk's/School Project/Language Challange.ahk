; Tree#3533, Language Project - Challange
; Version 1.00

#NoEnv ;Impore preformace by not checking empty variables against env ones.
#SingleInstance Force ;One instance of the program.
SetWorkingDir %A_ScriptDir% ;Sets the main directory to look for files in.

Translen := 0 ;Variables for later use.
Natilen := 0
Filereadline, Foreign, .\data\Settings.sdb, 7 ;Check if the settings are different
Loop, read, .\data\Trans.sdb ;Count the lines in the databases
	Translen += 1
Loop, read, .\data\Native.sdb
	Natilen += 1
if (Natilen != Translen) or (Natlen = 0) or (Translen = 0) ;Make sure that everything is there.
{
	MsgBox, Hey user you seem to be missing a translation or native word in the menu. Please fix this to continue. ;Inform the user.
	Return
}
Random, pos, 1, %Translen% ;Pick a random line for both.
Filereadline, Native, .\data\Native.sdb, %Pos% ;Get the words for that line.
Filereadline, Translation, .\data\Trans.sdb, %Pos%

Gui, Chall:New	, -MaximizeBox -MinimizeBox +AlwaysOnTop		, Challenge ;Create the challange GUI.

Gui, Chall:Add	, GroupBox		, xm ym+10 	Section w200 h80	, Learning: ;Create a reference point.
if Foreign ;Check if the foregin setting is changed.
	Gui, Chall:Add	, Text		, xs+10 ys+20					, %Translation% ;Translation to go to native.
else
	Gui, Chall:Add	, Text		, xs+10 ys+20					, %Native% ;Native to go to the translation.
Gui, Chall:Add	, Edit			, xs+10 ys+40 	vAnswer ;The answer box.

Gui, Chall:Add	, Button		, xm ym+100	w80 gButtonSub		, Submit ;Submit the answer.
Gui, Chall:Show	, W300 ;Make sure the user can actually see the thing.
Return

ButtonSub: ;Label for the submission.
	Gui, Chall:Submit, NoHide ;Submit any user input.
	Gui, ChallA:New	, -MaximizeBox -MinimizeBox +AlwaysOnTop +OwnerChall, Challenge ;Create a GUI bound to the origanal.
	if Foreign ;Another forign check.
	{
		if (Answer = Native) ;Non-case sensitive answer check.
		{
			Gui, ChallA:Add	, Text,, You got it correct well done. ;Congratulate the user.
			Gui, ChallA:Add	, Button		, xm ym+30	w80 gButtonExit		, Finish ;Close the GUI.
		}
		else
			Gui, ChallA:Add	, Text,, You got it wrong try again. ;Get them to attempt again.
	}
	else
	{
		if (Answer = Translation) ;Non-case sensitive answer check.
		{
			Gui, ChallA:Add	, Text,, You got it correct well done. ;Congratulate the user.
			Gui, ChallA:Add	, Button		, xm ym+30	w80 gButtonExit		, Finish ;Close the GUI.
		}
		else
			Gui, ChallA:Add	, Text,, You got it wrong try again. ;New attempt no change in words.
	}
	Gui, ChallA:Show, w200 ;Make sure the user can see it.
Return

ChallGuiClose: ;Delete the sui if it gets closed along with leave the script.
ButtonExit:
	Gui, Main:Destroy
ExitApp ;Close the script.
