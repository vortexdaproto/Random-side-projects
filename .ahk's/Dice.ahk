#NoEnv
#Warn
SendMode Input
SetWorkingDir %A_ScriptDir%
Sides := 2
Rolls := 1

DiceMain:
	Gui, Dice:New, -MaximizeBox +AlwaysOnTop, Dice
		Gui, Dice:Add, GroupBox, xm ym+10 Section w200 h70, Settings:
			Gui, Dice:Add, Edit, xs+80 ys+20 Number w100 vSides, %Sides%
			Gui, Dice:Add, Text, xs+10 ys+22, Sides:
			Gui, Dice:Add, Edit, xs+80 ys+40 Number w100 vRolls, %Rolls%
			Gui, Dice:Add, Text, xs+10 ys+42, Rolls:
		Gui, Dice:Add, Button, xm ym+95 w40 gDiceOK, Save
		Gui, Dice:Add, Button, xm+45 ym+95 w40 gDiceRoll, Roll
	Gui, Dice:Show, W300
Return

DiceOK:
	Gui, Dice:Submit, NoHide
Return

DiceRoll:
	Gui, Dice:Submit, NoHide
	Out := 0
	DiceOutput := ""
	Loop %Rolls%
	{
		Random, Num, 1, %Sides%
		DiceOutput := DiceOutput . Num
		Out += Num
	}
	Gui, DiceOut:New, -MaximizeBox -MinimizeBox +OwnerDice, Dice
	Gui, DiceOut:Add, Text, xm+10 ym+0, %Out%
	DiceOutlen := StrLen(DiceOutput)
	If(DiceOutlen > 43679)
	{
		FileDelete, %A_MyDocuments%\AHK\Diceout.txt
		FileAppend, %DiceOutput%, %A_MyDocuments%\AHK\Diceout.txt
		Gui, DiceOut:Add, Link,, <a href="%A_MyDocuments%\AHK\Diceout.txt">Output</a>
	}
	Else
		Gui, DiceOut:Add, Edit, xm+0 ym+20 w100 r1 ReadOnly, %DiceOutput%
	Gui, DiceOut:Show, w120
Return

DiceGuiClose:
	Gui, Dice:Destroy
Return