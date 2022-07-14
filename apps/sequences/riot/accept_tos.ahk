global hasSequenceRiotAcceptTosStarted := false

sequenceRiotAcceptTos() {
	if(hasSequenceRiotAcceptTosStarted) {
		return
	}
	hasSequenceRiotAcceptTosStarted := true

	sequence := new Sequence("Riot accept TOS")

	acceptTosSrollbarPayload := { successCallBack: func("sequenceRiotAcceptTosAction") , failureCallBack: func("nothing")}
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.SCREEN_CALLBACK, "AcceptTosSrollbar", screen_riot_tos, false, acceptTosSrollbarPayload))

	add_sequence(sequence)
}

sequenceRiotAcceptTosAction(options, result) {
	acceptTosPayload := { successCallBack: func("sequenceRiotAcceptTosClick") , failureCallBack: func("nothing")}
	acceptTosStep := new SequenceStep(SEQUENCE_STEP_TYPE.SCREEN_CALLBACK, "acceptTosStep", screen_riot_accept_tos,  false, acceptTosPayload)
	sequence_add_step_first(acceptTosStep)

	scrollToTosPayload := { start: { x: result.x, y: result.y }, end:  { x: 1015, y: 610 }}
	scrollToTos := new ScreenAction(ACTION_TYPE.DRAG_AND_DROP, "scrollToTos", scrollToTosPayload)
	scrollToTosStep := new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "scrollToTosStep", false,  scrollToTos)
	sequence_add_step_first(scrollToTosStep)
}

sequenceRiotAcceptTosClick(options, result) {
	acceptTosClick := new ScreenAction(ACTION_TYPE.CLICK_LEFT, "acceptTosClick", { x: result.x, y: result.y })
	acceptTosClickStep := new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "acceptTosClick", false,  acceptTosClick)
	remove_first_sequence_step()
	sequence_add_step_first(acceptTosClickStep)
}

sequenceRiotAcceptTosReset() {
	hasSequenceRiotAcceptTosStarted := false
}