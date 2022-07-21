#Include %A_ScriptDir%/apps/sequences/riot/login.ahk
#Include %A_ScriptDir%/apps/sequences/riot/launch_lol_client_from_riot_lobby.ahk
#Include %A_ScriptDir%/apps/sequences/riot/launch_lol_client_build.ahk
#Include %A_ScriptDir%/apps/sequences/riot/accept_tos.ahk

global hasSequenceRiotLaunchClientStarted := false

sequenceRiotLaunchClient() {
	if(hasSequenceRiotLaunchClientStarted) {
		return
	}
	hasSequenceRiotLaunchClientStarted := true

	sequence := new Sequence("Riot launch lol client", 15000)

	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.READ_TEXT, "riot_ocr", screen_riot_ocr, false, { successCallBack: func("sequenceRiotLaunchClientGetScreenFromText")}))
	add_sequence(sequence)
}

sequenceRiotLaunchClientGetScreenFromText(result) {
	resetSequenceRiotLaunchClient()
	if(string_contains(result.text, "Terms") && string_contains(result.text, "Service")) {
		log.add("SCREEN RIOT TOS")
		sequenceRiotAcceptTos()
		return
	}
	if(string_contains(result.text, "My") && string_contains(result.text, "Games")) {
		log.add("SCREEN RIOT LOBBY")
		sequenceLaunchLolClientFromRiotLobby()
		return
	}
	if(string_contains(result.text, "RIOT") && string_contains(result.text, "GAMES")) {
		log.add("SCREEN RIOT LOGIN")
		sequenceRiotLogin()
		return
	}
	if(string_contains(result.text, "LEAGUE") && string_contains(result.text, "LEGENDS")) {
		log.add("SCREEN RIOT PLAY LEAGUE")
		sequenceLaunchLolClientBuild()
		return
	}
}

resetSequenceRiotLaunchClient() {
	hasSequenceRiotLaunchClientStarted := false
}
