global hasSequenceLaunchLolClientFromRiotLobbyStarted := false

sequenceLaunchLolClientFromRiotLobby() {
	if(hasSequenceLaunchLolClientFromRiotLobbyStarted) {
		return
	}
	hasSequenceLaunchLolClientFromRiotLobbyStarted := true
	sequence := new Sequence("Riot launch lol client from lobby", 5000)

	launchPayload := { successCallBack: func("sequenceLaunchLolClientFromRiotLobbyClick") , failureCallBack: func("nothing")}
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.SCREEN_CALLBACK, "LaunchLoLClient", screen_riot_lol_play_cta, false, launchPayload))

	add_sequence(sequence)
}

sequenceLaunchLolClientFromRiotLobbyClick(options, result) {
	clickPlay := new ScreenAction(ACTION_TYPE.CLICK_LEFT, "LaunchLoLClientClick", { x: result.x + 10, y: result.y + 10, cooldown: 2000 })
	clickPlayStep := new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "LaunchLoLClientClick", false,  clickPlay)
	remove_first_sequence_step()
	sequence_add_step_first(clickPlayStep)
	resetLaunchLolClientFromRiotLobby()
}

resetLaunchLolClientFromRiotLobby() {
	hasSequenceLaunchLolClientFromRiotLobbyStarted := false
}