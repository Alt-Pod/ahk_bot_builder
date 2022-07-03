global hasSequenceCropImgWithGimpStarted := false

sequenceCropImgWithGimp(name, zone, callback) {
	if(hasSequenceCropImgWithGimpStarted) {
		return
	}
	hasSequenceCropImgWithGimpStarted := true

	sequence := new Sequence("Crop img with gimp")

	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.WAIT_FOR_SCREEN, "confirmGimpIsOpen", screen_gimp_open))

	copyPrintscreen := new ScreenAction(ACTION_TYPE.CTRL_SHIFT_KEY, "copyPrintscreen", { key: "v" })
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "copyPrintscreen", false,  copyPrintscreen))

	goToMenu := new ScreenAction(ACTION_TYPE.PRESS_KEY, "goToMenu", { key: "F10" })
	goToImageMenu := new ScreenAction(ACTION_TYPE.ARROW_RIGHT, "goToImageMenu")
	goToCanvasMenu := new ScreenAction(ACTION_TYPE.ARROW_BOTTOM, "goToCanvasMenu")
	openCanvasMenu := new ScreenAction(ACTION_TYPE.ENTER, "openCanvasMenu")

	openCanvasMenuStep := new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "openCanvasMenuStep", false, openCanvasMenu, { chainedStep: TODO })
	goToCanvasMenuStep := new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "goToCanvasMenuStep", false, goToCanvasMenu, { repeatedStep: 3, chainedStep: openCanvasMenuStep })
	goToImageMenuStep := new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "goToImageMenuStep", false, goToImageMenu, { repeatedStep: 3, chainedStep: goToCanvasMenuStep })
	goToMenuStep := new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "goToMenuStep", false, goToMenu, { chainedStep: goToImageMenuStep })
	sequence.addStep(goToMenuStep)

	confirmCanvasMenuOpen := new SequenceStep(SEQUENCE_STEP_TYPE.SCREEN_FAILURE_STEP, "confirmCanvasMenuOpen", screen_gimp_canvas_menu_open, false, { failureStep: goToMenuStep })
	sequence.addStep(confirmCanvasMenuOpen)

	xSize := zone.x2 - zone.x1
	selectAllInput := new ScreenAction(ACTION_TYPE.CTRL_KEY, "selectAllInput", { key: "a" })
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "selectAllInput", false,  selectAllInput))
	writeCanvasSize := new ScreenAction(ACTION_TYPE.WRITE, "writeCanvasSize", { text: xSize })
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "writeCanvasSize", false,  writeCanvasSize))

	changeField := new ScreenAction(ACTION_TYPE.TAB, "changeField")
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "changeField", false,  changeField))
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "changeField", false,  changeField))

	ySize := zone.y2 - zone.y1
	selectAllInput := new ScreenAction(ACTION_TYPE.CTRL_KEY, "selectAllInput", { key: "a" })
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "selectAllInput", false,  selectAllInput))
	writeCanvasSize := new ScreenAction(ACTION_TYPE.WRITE, "writeCanvasSize", { text: ySize })
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "writeCanvasSize", false,  writeCanvasSize))

	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "changeField", false,  changeField))
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "changeField", false,  changeField))

	selectAllInput := new ScreenAction(ACTION_TYPE.CTRL_KEY, "selectAllInput", { key: "a" })
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "selectAllInput", false,  selectAllInput))
	writeCanvasSize := new ScreenAction(ACTION_TYPE.WRITE, "writeCanvasSize", { text: text_concat("-", zone.x1) })
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "writeCanvasSize", false,  writeCanvasSize))

	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "changeField", false,  changeField))

	selectAllInput := new ScreenAction(ACTION_TYPE.CTRL_KEY, "selectAllInput", { key: "a" })
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "selectAllInput", false,  selectAllInput))
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

	writeFilename := new ScreenAction(ACTION_TYPE.WRITE, "writeFilename", { text: text_concat(A_ScriptDir,"\screens\img\", name)})
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "writeFilename", false,  writeFilename))

	validateFileName := new ScreenAction(ACTION_TYPE.ENTER, "validateFileName")
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "validateFileName", false,  validateFileName))

	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.WAIT_FOR_SCREEN, "confirmGimpFileExportIsOpen", screen_gimp_confirmation_export_modal))

	finalFileNameValidation := new ScreenAction(ACTION_TYPE.ENTER, "finalFileNameValidation")
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, "finalFileNameValidation", false,  finalFileNameValidation))

	closeFile := new ScreenAction(ACTION_TYPE.CTRL_KEY, "closeFile", { key: "w" })
	waitForCloseFileModal := new SequenceStep(SEQUENCE_STEP_TYPE.SCREEN_FAILURE_ACTION, "waitForCloseFileModal", screen_gimp_destroy_modal_confirmation, closeFile)
	sequence.addStep(waitForCloseFileModal)

	confirmCloseFile := new ScreenAction(ACTION_TYPE.CTRL_KEY, "confirmCloseFile", { key: "d" })
	gimpHome := new SequenceStep(SEQUENCE_STEP_TYPE.SCREEN_FAILURE_ACTION, "gimpHome", screen_gimp_open, confirmCloseFile)
	sequence.addStep(gimpHome)

	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.EMPTY, "resetSequence", false, false, { callback: func("resetSequenceCropImgWithGimp") } ))
	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.EMPTY, "updateData", false, false, { callback: callback } ))

	add_sequence(sequence)
}

resetSequenceCropImgWithGimp() {
	hasSequenceCropImgWithGimpStarted := false
}