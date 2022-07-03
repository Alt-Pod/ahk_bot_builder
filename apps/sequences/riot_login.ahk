global hasSequenceRiotLoginStarted := false

sequenceRiotLogin() {
	if(hasSequenceRiotLoginStarted) {
		return
	}
	hasSequenceRiotLoginStarted := true
	sequence := new Sequence("Riot login")

	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.WAIT_FOR_SCREEN, "confirmRiotIsOpen", screen_riot_login))
	
	changeField := new ScreenAction(ACTION_TYPE.TAB, "changeField")
	usernameLoginActive := new SequenceStep(SEQUENCE_STEP_TYPE.SCREEN_FAILURE_ACTION, "usernameLoginActive", screen_riot_login_username_input, changeField)

	selectAllInput := new ScreenAction(ACTION_TYPE.CTRL_KEY, "selectAllInput", { key: "a" })
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "selectAllInput", false,  selectAllInput))
	writeLogin := new ScreenAction(ACTION_TYPE.WRITE, "writeCanvasSize", { text: ySize })
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "writeCanvasSize", false,  writeCanvasSize))

	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.EMPTY, "resetSequence", false, false, { callback: func("resetSequenceRiotLogin") } ))
	add_sequence(sequence)
}


resetSequenceRiotLogin() {
	hasSequenceRiotLoginStarted := false
}