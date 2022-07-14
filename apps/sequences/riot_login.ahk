global hasSequenceRiotLoginStarted := false

sequenceRiotLogin() {
	if(hasSequenceRiotLoginStarted) {
		return
	}
	hasSequenceRiotLoginStarted := true
	sequence := new Sequence("Riot login")

	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.WAIT_FOR_SCREEN, "confirmRiotIsOpen", screen_riot_login))
	
	changeField := new ScreenAction(ACTION_TYPE.TAB, "changeField", { cooldown: 100 })
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

	login := new ScreenAction(ACTION_TYPE.ENTER, "login", { cooldown: 3000 })
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "login", false,  login))

	sequenceRiotPostLogin := { successCallBack: func("sequenceRiotPostLogin")
		, failureCallBack: func("nothing")
		, screenCollection: [screen_riot_lol_play_cta, screen_riot_tos] }
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.MULTIPLE_SCREEN_CALLBACK, "sequenceRiotPostLogin", false, false, sequenceRiotPostLogin))

	launchPayload := { successCallBack: func("sequenceRiotLoginLaunchLoLClientClick") , failureCallBack: func("nothing")}
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.SCREEN_CALLBACK, "LaunchLoLClient", screen_riot_launch_lol_client, false, launchPayload))

	add_sequence(sequence)
}


resetSequenceRiotLogin() {
	hasSequenceRiotLoginStarted := false
}

sequenceRiotLoginLaunchLoLClientClick(options, result) {
	clickPlay := new ScreenAction(ACTION_TYPE.CLICK_LEFT, "LaunchLoLClient", { x: result.x, y: result.y })
	clickPlayStep := new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "LaunchLoLClient", false,  clickPlay)
	remove_first_sequence_step()
	sequence_add_step_first(clickPlayStep)
}

sequenceRiotPostLogin(options, result) {
	if(options.windowSearchName == screen_riot_lol_play_cta.name) {
		clickPlay := new ScreenAction(ACTION_TYPE.CLICK_LEFT_OFFSET, "clickPlay", { x: result.x, y: result.y, offsetX: 15, offsetY: 20 })
		clickPlayStep := new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "clickPlay", false,  clickPlay)
		remove_first_sequence_step()
		sequence_add_step_first(clickPlayStep)
		return
	}
	if(options.windowSearchName == screen_riot_tos.name) {
		acceptTosPayload := { successCallBack: func("sequenceRiotPostLoginAcceptTos") , failureCallBack: func("nothing")}
		acceptTosStep := new SequenceStep(SEQUENCE_STEP_TYPE.SCREEN_CALLBACK, "acceptTosStep", screen_riot_accept_tos,  false, acceptTosPayload)
		sequence_add_step_first(acceptTosStep)

		scrollToTosPayload := { start: { x: result.x, y: result.y }, end:  { x: 1015, y: 610 }}
		scrollToTos := new ScreenAction(ACTION_TYPE.DRAG_AND_DROP, "scrollToTos", scrollToTosPayload)
		scrollToTosStep := new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "scrollToTosStep", false,  scrollToTos)
		sequence_add_step_first(scrollToTosStep)
		return
	}
}

sequenceRiotPostLoginAcceptTos(options, result) {
	acceptTosClick := new ScreenAction(ACTION_TYPE.CLICK_LEFT, "acceptTosClick", { x: result.x, y: result.y })
	acceptTosClickStep := new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "acceptTosClick", false,  acceptTosClick)
	remove_first_sequence_step()
	sequence_add_step_first(acceptTosClickStep)
}

