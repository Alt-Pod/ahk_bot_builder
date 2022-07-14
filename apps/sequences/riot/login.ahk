global hasSequenceRiotLoginStarted := false

sequenceRiotLogin() {
	if(hasSequenceRiotLoginStarted) {
		return
	}
	hasSequenceRiotLoginStarted := true
	
	sequence := new Sequence("Riot login")

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

	add_sequence(sequence)
}

sequenceRiotLoginReset() {
	hasSequenceRiotLoginStarted := false
}