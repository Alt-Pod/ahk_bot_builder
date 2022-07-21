global hasSequenceLolClientLaunchAramStarted := false

sequenceLolClientLaunchAram() {
	if(hasSequenceLolClientLaunchAramStarted) {
		return
	}
	hasSequenceLolClientLaunchAramStarted := true

	sequence := new Sequence("Lol client launch Aram")

	waitLolClientLaunchAram := new ScreenAction(ACTION_TYPE.EMPTY, "waitLolClientLaunchAram", { cooldown: 2000 })
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "waitLolClientLaunchAram", false,  waitLolClientLaunchAram))

	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.READ_TEXT, "lol_client_tos_ocr", screen_lol_client_tos_ocr, false, { successCallBack: func("sequenceRiotLaunchClientGetScreenFromText")}))

	add_sequence(sequence)
}

sequenceLolClientLaunchAramReset() {
	hasSequenceLolClientLaunchAramStarted := false
}













sequenceLolClientLaunchAram2() {
	if(hasSequenceLolClientLaunchAramStarted) {
		return
	}
	hasSequenceLolClientLaunchAramStarted := true

	sequence := new Sequence("Lol client launch Aram")

	clientSplashPayload := { successCallBack: func("sequenceLolClientLaunchAramClientClick")
		, failureCallBack: func("nothing")
		, screenCollection: [screen_lol_client_game_mod
			, screen_lol_client_popup_email
			, screen_lol_client_splash_play_button
			, screen_lol_client_close_dragonland_popup
			, screen_lol_client_tos
			, screen_lol_client_accept_tos
			, screen_lol_client_popup_summoner_icon
			, screen_lol_client_ranked_popup
			, screen_lol_client_popup_challenge_tier] }
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.MULTIPLE_SCREEN_CALLBACK, "lolClientSplash", false, false, clientSplashPayload))

	selectGameModPayload := { successCallBack: func("sequenceLolClientSelectGameMod") , failureCallBack: func("sequenceLolClientSelectGameModFailure")}
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.SCREEN_CALLBACK, "LoLPlayCta", screen_lol_client_game_mod, false, selectGameModPayload))

	selectAram := new ScreenAction(ACTION_TYPE.CLICK_LEFT, "selectAram", { x: 500, y: 220 })
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "selectAram", false,  selectAram))

	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.WAIT_FOR_SCREEN, "aramSelected", screen_lol_client_game_mod_aram))

	goToAramLobby := new ScreenAction(ACTION_TYPE.CLICK_LEFT, "goToAramLobby", { x: 540, y: 685 })
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "goToAramLobby", false,  goToAramLobby))

	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.WAIT_FOR_SCREEN, "aramLobby", screen_lol_client_aram_lobby))

	waitAramLobby := new ScreenAction(ACTION_TYPE.EMPTY, "waitAramLobby", { cooldown: 1000 })
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "waitAramLobby", false,  waitAramLobby))

	launchAramQueue := new ScreenAction(ACTION_TYPE.CLICK_LEFT, "launchAramQueue", { x: 520, y: 680 })
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "launchAramQueue", false,  launchAramQueue))

	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.WAIT_FOR_SCREEN, "aramInQueue", screen_lol_client_aram_in_queue))

	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.WAIT_FOR_SCREEN, "aramFoundGame", screen_lol_client_found_aram_game))

	aramJoinGameLobby := new ScreenAction(ACTION_TYPE.CLICK_LEFT, "aramJoinGameLobby", { x: 640, y: 555 })
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "aramJoinGameLobby", false,  aramJoinGameLobby))

	add_sequence(sequence)
}

sequenceLolClientLaunchAramClientClick(options, result) {
	wsName := options.windowSearchName
	if(wsName == screen_lol_client_game_mod.name) {
		remove_first_sequence_step()
		return
	}
	if(wsName == screen_lol_client_tos.name) {
		click := new ScreenAction(ACTION_TYPE.CLICK_LEFT, "lolClientLaunchAramTos", { x: 963, y: 540, cooldown: 1000 })
		clickStep := new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "lolClientLaunchAramTos", false,  click)
		sequence_add_step_first(clickStep)

		click := new ScreenAction(ACTION_TYPE.CLICK_LEFT, "lolClientLaunchAramTos", { x: 963, y: 430, cooldown: 1000 })
		clickStep := new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "lolClientLaunchAramTos", false,  click)
		sequence_add_step_first(clickStep)

		click := new ScreenAction(ACTION_TYPE.CLICK_LEFT, "lolClientLaunchAramTos", { x: 963, y: 316, cooldown: 1000 })
		clickStep := new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "lolClientLaunchAramTos", false,  click)
		sequence_add_step_first(clickStep)

		click := new ScreenAction(ACTION_TYPE.CLICK_LEFT, "lolClientLaunchAramTos", { x: 963, y: 205, cooldown: 1000 })
		clickStep := new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "lolClientLaunchAramTos", false,  click)
		sequence_add_step_first(clickStep)
		return
	}
	if(wsName == screen_lol_client_splash_play_button.name) {
		remove_first_sequence_step()
	}
	if(wsName == screen_lol_client_popup_email.name 
		|| wsName == screen_lol_client_splash_play_button.name
		|| wsName == screen_lol_client_accept_tos.name) {

		clickPayload := { x: result.x, y: result.y, offsetX: 10, offsetY: 10 }
		click := new ScreenAction(ACTION_TYPE.CLICK_LEFT_OFFSET, "lolClientLaunchAramClientClick", clickPayload)
		clickStep := new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "lolClientLaunchAramClientClick", false,  click)
		sequence_add_step_first(clickStep)

		waitLolClientLaunchAram := new ScreenAction(ACTION_TYPE.EMPTY, "waitLolClientLaunchAram", { cooldown: 1000 })
		waitStep := new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "waitLolClientLaunchAram", false,  waitLolClientLaunchAram)
		sequence_add_step_first(waitStep)
		return
	}
	if(wsName == screen_lol_client_close_dragonland_popup.name 
		|| screen_lol_client_popup_summoner_icon.name 
		|| screen_lol_client_ranked_popup.name 
		|| screen_lol_client_popup_challenge_tier.name) {
		click := new ScreenAction(ACTION_TYPE.CLICK_LEFT, "lolClientLaunchAramClientClick", { x: result.x, y: result.y })
		clickStep := new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "lolClientLaunchAramClientClick", false,  click)
		sequence_add_step_first(clickStep)

		waitLolClientLaunchAram := new ScreenAction(ACTION_TYPE.EMPTY, "waitLolClientLaunchAram", { cooldown: 1000 })
		waitStep := new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "waitLolClientLaunchAram", false,  waitLolClientLaunchAram)
		sequence_add_step_first(waitStep)
		return
	}
}

sequenceLolClientSelectGameMod() {
	remove_first_sequence_step()
}

sequenceLolClientSelectGameModFailure() {
	clientSplashPayload := { successCallBack: func("sequenceLolClientLaunchAramClientClick")
		, failureCallBack: func("nothing")
		, screenCollection: [screen_lol_client_game_mod, screen_lol_client_popup_email, screen_lol_client_splash_play_button] }
	sequenceStep := new SequenceStep(SEQUENCE_STEP_TYPE.MULTIPLE_SCREEN_CALLBACK, "lolClientSplash", false, false, clientSplashPayload)
	sequence_add_step_first(sequenceStep)
}