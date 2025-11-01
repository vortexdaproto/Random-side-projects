#NoEnv
#Warn
SendMode Input
SetWorkingDir %A_ScriptDir%
countTeamTotal := 30
countPlayersTotal := 15
generateTeams := 5


TeamsMain:
	Gui, Teams:New, -MaximizeBox +AlwaysOnTop, Teams
		Gui, Teams:Add, GroupBox, xm ym+10 Section w300 h70, Settings:
			Gui, Teams:Add, Edit, xs+55 ys+20 Number w40 vcountTeamTotal, %countTeamTotal%
			Gui, Teams:Add, Text, xs+10 ys+22, Teams:
			
			Gui, Teams:Add, Edit, xs+55 ys+45 Number w40 vcountPlayersTotal, %countPlayersTotal%
			Gui, Teams:Add, Text, xs+10 ys+47, Players:
			
			Gui, Teams:Add, Edit, xs+195 ys+32.5 Number w40 vgenerateTeams, %generateTeams%
			Gui, Teams:Add, Text, xs+105 ys+35.5, Total to generate:
			
		Gui, Teams:Add, Button, xm ym+95 w40 gTeamsOK, Save
		Gui, Teams:Add, Button, xm+45 ym+95 w40 gTeamsRoll, Roll
	Gui, Teams:Show, W300
Return

TeamsOK:
	Gui, Teams:Submit, NoHide
Return

TeamsRoll:
	Gui, Teams:Submit, NoHide
	
	player1Team := ""
	player1Player := ""
	player2Team := ""
	player2Player := ""
	Loop %generateTeams%
	{
		Random, Num1, 1, %countTeamTotal%
		player1Team := player1Team . " " . Num1
		Random, Num2, 1, %countTeamTotal%
		player2Team := player2Team . " " . Num2
		
		Random, Num3, 1, %countPlayersTotal%
		player2Player := player2Player . " " . Num3
		Random, Num4, 1, %countPlayersTotal%
		player1Player := player1Player . " " . Num4
	}
	
	
	Gui, TeamsOut:New, -MaximizeBox -MinimizeBox +OwnerTeams, Teams
		Gui, TeamsOut:Add, GroupBox, xm ym+10 Section w150 h90, Player1
			Gui, TeamsOut:Add, Text, xs+5 ys+10, Teams:
			Gui, TeamsOut:Add, Edit, xs+5 ys+25 w100 r1 ReadOnly, %player1Team%
			Gui, TeamsOut:Add, Text, xs+5 ys+50, Players:
			Gui, TeamsOut:Add, Edit, xs+5 ys+65 w100 r1 ReadOnly, %player1Player%
		Gui, TeamsOut:Add, GroupBox, xm+160 ym+10 Section w150 h90, Player2
			Gui, TeamsOut:Add, Text, xs+5 ys+10, Teams:
			Gui, TeamsOut:Add, Edit, xs+5 ys+25 w100 r1 ReadOnly, %player2Team%
			Gui, TeamsOut:Add, Text, xs+5 ys+50, Players:
			Gui, TeamsOut:Add, Edit, xs+5 ys+65 w100 r1 ReadOnly, %player2Player%
	Gui, TeamsOut:Show, w400
Return

TeamsGuiClose:
	Gui, Teams:Destroy
Return