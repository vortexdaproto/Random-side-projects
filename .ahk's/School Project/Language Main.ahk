; Tree#3533, Language Project - Main
; Version 1.00

#NoEnv ;Impore preformace by not checking empty variables against env ones.
#SingleInstance Force ;One instance of the program.
SetWorkingDir %A_ScriptDir% ;Sets the main directory to look for files in.


Translen := 0 ;Create two variables for later use.
Natilen := 0
FileRead, Transdata, .\data\Trans.sdb ;Get the data from the database for use in the GUI.
FileRead, Natidata, .\data\Native.sdb
Filereadline, hk, .\data\Settings.sdb, 2
Filereadline, Timeh, .\data\Settings.sdb, 4
Filereadline, Timem, .\data\Settings.sdb, 5
Filereadline, Foreign, .\data\Settings.sdb, 7

Check := (((Timeh*60)+Timem)*60)*1000 ;Getting the time for the challange system.
Settimer, Challange, %Check% ;The timer for the challange system.

Loop, read, .\data\Trans.sdb ;Get the length of the Files to put into the GUI.
	Translen += 1
Loop, read, .\data\Native.sdb 
	Natilen += 1


Hotkey, %hk%, Main ;Setup the hotkey using data from the files.
gosub Main ;Run the Gui when the progam starts (suggested in user testing).
Return

Main: ;label to run if hotkey is pressed.
	Gui, Main:New	, -MaximizeBox -MinimizeBox +AlwaysOnTop				, Language Project ;Create the Gui without max or minimize box.
	Gui, Main:Color	, DDDDDD, FFFFFF ;Sets a nice gray colour for the GUI.

	Gui, Main:Add	, GroupBox		, xm 		ym+10 	Section w200 h82 c000000	, Settings: ;Create a reference point for the settings.
	Gui, Main:Add	, Text			, xs+10		ys+22						, Time:	;Label what something does.
	Gui, Main:Add	, Edit			, xs+50 	ys+20	Number	w40 vTimeh	, %Timeh% ;Time for the hours.
	Gui, Main:Add	, Text			, xs+50		ys+42						, (Hours) ;Label the hours edit box.
	Gui, Main:Add	, Edit			, xs+100 	ys+20	Number	w40 vTimem	, %Timem% ;Time for the minutes.
	Gui, Main:Add	, Text			, xs+100	ys+42						, (Minutes) ;Label the minutes edit box.
	Gui, Main:Add	, Checkbox		, xs+10		ys+62	vForeign Checked%Foreign%, Enable Foreign --> Native ;A checkbox to change how the challenge works.

	Gui, Main:Add	, GroupBox		, xm		ym+112	Section w200 h62 c000000	, Hotkey: ;Create another reference point for the Hotkey.
	Gui, Main:Add	, Edit			, xs+40		ys+20	vhk w40				, %hk% ;Denote what it is currently along with allow it to be edited.
	Gui, Main:Add	, Text			, xs+10		ys+22						, Key: ;Gotta have that lebel.
	Gui, Main:Add	, Text			, xs+10		ys+42						, (Crtl:^, Alt: !, Shift: +, Win key: #) ;Say what can change what for hotkeys.
	
	Gui, Main:Add	, GroupBox		, xm+220	ym+10	Section	w400 h172 c000000	, Words: ;Another reference point for word adding.
	Gui, Main:Add	, Edit			, xs+10 	ys+42	w185 r6 vNative		, %Natidata% ;Edit box for the native words.
	Gui, Main:Add	, Text			, xs+10		ys+20						, Native: %Natilen% ;Labeling.
	Gui, Main:Add	, Edit			, xs+205 	ys+42	w185 r6 vTrans		, %Transdata% ;Edit box for the translation of the words.
	Gui, Main:Add	, Text			, xs+205	ys+20						, Translation: %Translen% ;Labeling.
	Gui, Main:Add	, Button		, xs+10		ys+142	w80 gWordupload		, Upload ;Upload any data entered to storage.
	Gui, Main:Add	, Button		, xs+110	ys+142	w100 gChallange		, Quick Challange ;Quickly run a challange.

	Gui, Main:Add	, Button		, xm		ym+196	w80 gButtonSave		, Save ;Upload any data entered to storage
	Gui, Main:Add	, Button		, xm+100	ym+196	w80 gButtonExit		, Exit ;Close the GUI and delete any unsaved data
	Gui, Main:Show	, W640
Return

MainGuiClose: ;If GUI closed at all delete it.
ButtonExit:
	Gui, Main:Destroy 
Return

Wordupload: ;Labels from the buttonss on the GUI.
ButtonSave:
	Gui, Main:Submit ;Submit the file to get any user input.
	Gui, Main:Destroy ;Not nessacary but delete the GUI.
	FileDelete, .\data\Trans.sdb ;Delete the files to allow update.
	FileDelete, .\data\Native.sdb
	Filedelete, .\data\Settings.sdb
	Fileappend, Hotkey:`n%hk%`nTime between popups:`n%Timeh%`n%Timem%`nForeign --> Native:`n%Foreign%, .\data\Settings.sdb ;Upload the data recreating the file.
    FileAppend, %Trans%, .\data\Trans.sdb
    FileAppend, %Native%, .\data\Native.sdb
	Reload ;Reload the script.
Return

Challange: ;Label for the challenge.
	process, exist, .\Language Challange.exe ;Check if the program is running
	if ErrorLevel != 0 ;If challenge running don't rerun.
		Return
	Run, .\Language Challange.exe ;Run the challenge.
Return
