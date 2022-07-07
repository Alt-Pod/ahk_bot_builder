global hasSequenceRiotLoginStarted := false

sequenceRiotLogin() {
	if(hasSequenceRiotLoginStarted) {
		return
	}
	hasSequenceRiotLoginStarted := true
	sequence := new Sequence("Riot login")

	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.WAIT_FOR_SCREEN, "confirmRiotIsOpen", screen_riot_login))
	
	changeField := new ScreenAction(ACTION_TYPE.TAB, "changeField", { cooldown: 50 })
	usernameLoginActive := new SequenceStep(SEQUENCE_STEP_TYPE.SCREEN_FAILURE_ACTION, "usernameLoginActive", screen_riot_login_username_input, changeField)
	sequence.addStep(usernameLoginActive)

	selectAllInput := new ScreenAction(ACTION_TYPE.CTRL_KEY, "selectAllInput", { key: "a" })
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "selectAllInput", false,  selectAllInput))
	writeLogin := new ScreenAction(ACTION_TYPE.WRITE, "writeLogin", { text: credentials.RIOT_LOGIN })
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "writeLogin", false,  writeLogin))

	passwordLoginActive := new SequenceStep(SEQUENCE_STEP_TYPE.SCREEN_FAILURE_ACTION, "passwordLoginActive", screen_riot_login_password_input, changeField)
	sequence.addStep(passwordLoginActive)

	selectAllInput := new ScreenAction(ACTION_TYPE.CTRL_KEY, "selectAllInput", { key: "a" })
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "selectAllInput", false,  selectAllInput))
	writePassword := new ScreenAction(ACTION_TYPE.WRITE, "writePassword", { text: credentials.RIOT_PASSWORD })
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "writePassword", false,  writePassword))

	login := new ScreenAction(ACTION_TYPE.ENTER, "login")
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "login", false,  login))

	playPayload := { successCallBack: func("sequenceRiotLoginClick") , failureCallBack: func("nothing")}
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.SCREEN_CALLBACK, "LoLPlayCta", screen_riot_lol_play_cta, false, playPayload))
 
	launchPayload := { successCallBack: func("sequenceRiotLoginLaunchLoLClientClick") , failureCallBack: func("nothing")}
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.SCREEN_CALLBACK, "LaunchLoLClient", screen_riot_launch_lol_client, false, launchPayload))

	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.EMPTY, "resetSequence", false, false, { callback: func("resetSequenceRiotLogin") } ))
	
	add_sequence(sequence)
}


resetSequenceRiotLogin() {
	hasSequenceRiotLoginStarted := false
}

sequenceRiotLoginClick(options, result) {
	clickPlay := new ScreenAction(ACTION_TYPE.CLICK_LEFT_OFFSET, "clickPlay", { x: result.x, y: result.y, offsetX: 15, offsetY: 20 })
	clickPlayStep := new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "clickPlay", false,  clickPlay)
	remove_first_sequence_step()
	sequence_add_step_first(clickPlayStep)
}

sequenceRiotLoginLaunchLoLClientClick(options, result) {
	clickPlay := new ScreenAction(ACTION_TYPE.CLICK_LEFT, "clickPlay", { x: result.x, y: result.y })
	clickPlayStep := new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "clickPlay", false,  clickPlay)
	remove_first_sequence_step()
	sequence_add_step_first(clickPlayStep)
}
