global hasSequenceCropImgWithGimpStarted := false

sequenceCropImgWithGimp(name, zone) {
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

	xSize := zone.x2 - zone.x1
	writeCanvasSize := new ScreenAction(ACTION_TYPE.WRITE, "writeCanvasSize", { text: xSize })
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "writeCanvasSize", false,  writeCanvasSize))

	changeField := new ScreenAction(ACTION_TYPE.TAB, "changeField")
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "changeField", false,  changeField))
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "changeField", false,  changeField))

	ySize := zone.y2 - zone.y1
	writeCanvasSize := new ScreenAction(ACTION_TYPE.WRITE, "writeCanvasSize", { text: ySize })
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "writeCanvasSize", false,  writeCanvasSize))

	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "changeField", false,  changeField))
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "changeField", false,  changeField))

	writeCanvasSize := new ScreenAction(ACTION_TYPE.WRITE, "writeCanvasSize", { text: text_concat("-", zone.x1) })
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "writeCanvasSize", false,  writeCanvasSize))

	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "changeField", false,  changeField))

	writeCanvasSize := new ScreenAction(ACTION_TYPE.WRITE, "writeCanvasSize", { text: text_concat("-", zone.y1) })
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "writeCanvasSize", false,  writeCanvasSize))

	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "changeField", false,  changeField))
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "changeField", false,  changeField))
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "changeField", false,  changeField))
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "changeField", false,  changeField))
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "changeField", false,  changeField))
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "changeField", false,  changeField))

	validateCanvas := new ScreenAction(ACTION_TYPE.ENTER, "validateCanvas")
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "validateCanvas", false,  validateCanvas))

	exportFile := new ScreenAction(ACTION_TYPE.CTRL_SHIFT_KEY, "copyPrintscreen", { key: "e" })
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "exportFile", false,  exportFile))

	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.WAIT_FOR_SCREEN, "confirmGimpFileExportIsOpen", screen_gimp_file_export_open))

	add_sequence(sequence)
}