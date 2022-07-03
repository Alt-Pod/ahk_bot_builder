global hasSequenceCropImgWithGimpStarted := false

sequenceCropImgWithGimp() {
	if(hasSequenceCropImgWithGimpStarted) {
		return
	}
	hasSequenceCropImgWithGimpStarted := true

	sequence := new Sequence("Crop img with gimp")

	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.WAIT_FOR_SCREEN, "confirmGimpIsOpen", screen_gimp_open))

	copyPrintscreen := new ScreenAction(ACTION_TYPE.CTRL_SHIFT_KEY, "copyPrintscreen", { key: "v" })
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "copyPrintscreen", false,  copyPrintscreen))

	openMenu := new ScreenAction(ACTION_TYPE.CLICK_LEFT, "openMenu", { x: 180, y:  42})
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.SCREEN_FAILURE_ACTION, "confirmGimpMenuIsOpen", screen_gimp_image_menu_open, openMenu))

	openCanvasMenu := new ScreenAction(ACTION_TYPE.CLICK_LEFT, "openCanvasMenu", { x: 215, y:  135})
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.SCREEN_FAILURE_ACTION, "confirmOpenCanvasMenu", screen_gimp_canvas_menu_open, openCanvasMenu))

	writeCanvasSize := new ScreenAction(ACTION_TYPE.WRITE, "writeCanvasSize", { text: "696" })
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "writeCanvasSize", false,  writeCanvasSize))
	
	add_sequence(sequence)
}