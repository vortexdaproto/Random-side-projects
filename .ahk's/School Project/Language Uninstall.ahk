; Tree#3533, Language Project - Uninstall
; Version 1.00

#NoEnv ;Impore preformace by not checking empty variables against env ones.
#SingleInstance Force ;One instance of the program.
SetWorkingDir %A_AppData% ;Sets the main directory to look for files in.
Sleep, 2000 ;Wait.
if (A_ScriptFullPath == A_Desktop . "\Delete-me.exe") ;Chack if we are out of the folder to allow deletion.
{
	FileRemoveDir, %A_AppData%\Language-Project-main, 1 ;Delete the file.
	MsgBox, Deletion complete you may delete the file on your desktop. ;Inform the user.
}
else
{
	MsgBox, 4, Continue, Are you sure you want to delete Language Project. ;Double check.
	IfMsgBox, No ;If No then don't delete.
		Return
	FileCopy, %A_ScriptFullPath%, %A_Desktop%\Delete-me.exe ;Moves the file to allow deleting.
	Run, %A_Desktop%\Delete-me.exe ;Runs it.
	ExitApp ;Exits the application.
}