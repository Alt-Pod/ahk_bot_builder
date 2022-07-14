global hasSequencLaunchLolClientBuildStarted := false

sequenceLaunchLolClientBuild() {
	if(hasSequencLaunchLolClientBuildStarted) {
		return
	}
	hasSequencLaunchLolClientBuildStarted := true
	sequence := new Sequence("Riot launch lol client build")

	launchPayload := { successCallBack: func("sequenceLaunchLolClientBuildClick") , failureCallBack: func("nothing")}
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.SCREEN_CALLBACK, "LaunchLoLClientBuild", screen_riot_launch_lol_client, false, launchPayload))

	add_sequence(sequence)
}

sequenceLaunchLolClientBuildClick(options, result) {
	clickPlay := new ScreenAction(ACTION_TYPE.CLICK_LEFT, "LaunchLoLClientBuildClick", { x: result.x, y: result.y, cooldown: 3000 })
	clickPlayStep := new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "LaunchLoLClientBuildClick", false,  clickPlay)
	remove_first_sequence_step()
	sequence_add_step_first(clickPlayStep)
}


resetLaunchLolClientBuild() {
	hasSequencLaunchLolClientBuildStarted := false
}