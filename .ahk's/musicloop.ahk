#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
loop
{
	FileReadLine, Music, C:\Users\jkbla\OneDrive\Documents\AHK\music.txt, %A_Index%
	If ErrorLevel
	{
		Break
	}
	ID := Music[0-9]
	If Removed Copyright
	{
		TF_RemoveLines("C:\Users\jkbla\OneDrive\Documents\AHK\music.txt", %A_Index%, %A_Index%)
		FileMove, C:\Users\jkbla\OneDrive\Documents\AHK\music_copy.txt, C:\Users\jkbla\OneDrive\Documents\AHK\music.txt, 1
	}
}