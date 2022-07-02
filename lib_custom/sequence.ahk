handle_sequence() {
	sequences := CYCLE_DATA.sequences
	if(!sequences || sequences.length() == 0 || CYCLE_DATA.hasEngineWorked) {
		return
	}
	CYCLE_DATA.hasEngineWorked := true
	sequence := array_first(sequences)
	if(sequence.hasEnded) {
		remove_first_sequence()
	} else {
		sequence.play()
	}
	CYCLE_DATA.sequences := sequences
}

add_sequence(sequence) {
	sequences := CYCLE_DATA.sequences
	sequences.push(sequence)
	CYCLE_DATA.sequences := sequences
}

remove_first_sequence() {
	sequences := CYCLE_DATA.sequences
	sequences := array_removeFirst(sequences)
	CYCLE_DATA.sequences := sequences
}

class Sequence {
	__New(name) {
		this.name := name
		this.hasStarted := false
		this.hasEnded := false
		this.steps := []
	}

	addStep(sequenceStep) {
		this.steps.push(sequenceStep) 
	}

	addStepFirst(sequenceStep) {
		this.steps := array_pushFirst(this.steps, sequenceStep) 
	}

	play() {
		if(!this.hasStarted) {
			this.hasStarted := true
			log.add(text_concat("SEQUENCE ", this.name, " has started"))
		}
		if(this.steps.length() == 0) {
			this.end()
			return
		}
		step := array_first(this.steps)
		if(step.isFinished) {
			this.removeStep(step.id)
			return
		}
		step.run()
	}

	removeStep(id) {
		newSteps := []
		Loop % this.steps.length() {
			if(this.steps[A_Index].id != id) {
				newSteps.push(this.steps[A_Index])
			}
		}
		this.steps := newSteps
	}

	end() {
		this.hasEnded := true
		log.add(text_concat("SEQUENCE ", this.name, " has ended"))
	}
}

global SEQUENCE_STEP_TYPE := { WAIT_FOR_SCREEN: "WAIT_FOR_SCREEN"
	, ACTION: "ACTION"
	, SCREEN_FAILURE_ACTION: "SCREEN_FAILURE_ACTION" }

remove_sequence_step_from_sequence(payload) {
	if(!payload || !payload.stepIdToBeRemoved) {
		log.add("A remove sequence step by id operation was launched but no id for step was found", true)
	}
	id := payload.stepIdToBeRemoved
	sequences := CYCLE_DATA.sequences
	sequence := array_first(sequences)

	sequence.removeStep(id)

	sequences := array_removeFirst(sequences)
	CYCLE_DATA.sequences := array_pushFirst(sequences, sequence)
}

sequence_add_step_first(step) {
	if(!step) {
		log.add("A sequence add step firstwas launched but no step was found", true)
	}
	sequences := CYCLE_DATA.sequences
	sequence := array_first(sequences)

	sequence.addStepFirst(step)
	
	sequences := array_removeFirst(sequences)
	CYCLE_DATA.sequences := array_pushFirst(sequences, sequence)
}

sequence_step_do_nothing() {
	; DO NOTHING
}

sequence_add_step_first_as_action(payload) {
	if(!payload || !payload.action) {
		log.add("A sequence add step first as action was launched but no action was found", true)
	}
	action := payload.action
	sequenceStep := new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, action.name, false,  action)
	sequence_add_step_first(sequenceStep)
}

class SequenceStep {
	__New(type, name = "undefined", windowSearch = false, action = false) {
		this.id := random_guid()
		this.name := name
		this.type := type
		this.windowSearch := windowSearch
		this.action := action
		this.isFinished := false
		this.setup()
	}

	run() {
		if(this.type == SEQUENCE_STEP_TYPE.WAIT_FOR_SCREEN) {
			this.runWaitForScreen()
		}
		if(this.type == SEQUENCE_STEP_TYPE.ACTION) {
			this.runAction()
		}
		if(this.type == SEQUENCE_STEP_TYPE.SCREEN_FAILURE_ACTION) {
			this.runScreenFailureAction()
		}
	}

	runScreenFailureAction() {
		add_window_search_to_ui_scan(this.windowSearch
			, func("remove_sequence_step_from_sequence")
			, func("sequence_add_step_first_as_action")
			, { action: this.action, stepIdToBeRemoved: this.id })
	}

	runAction() {
		add_action(this.action)
		this.isFinished := true
	}

	runWaitForScreen() {
		add_window_search_to_ui_scan(this.windowSearch
			, func("remove_sequence_step_from_sequence")
			, func("sequence_step_do_nothing")
			, { stepIdToBeRemoved: this.id })
	}

	setup() {
		if(!this.type) {
			log.add(text_concat("SEQUENCE STEP - Missing type for ", this.name), true)
		}
		if(this.type == SEQUENCE_STEP_TYPE.WAIT_FOR_SCREEN && !this.windowSearch) {
			log.add(text_concat("SEQUENCE STEP - Missing window search for ", this.name, ", type : " this.type), true)
		}
		if(this.type == SEQUENCE_STEP_TYPE.ACTION && !this.action) {
			log.add(text_concat("SEQUENCE STEP - Missing action for ", this.name, ", type : " this.type), true)
		}
		if(this.type == SEQUENCE_STEP_TYPE.SCREEN_FAILURE_ACTION && (!this.action ||  !this.windowSearch)) {
			log.add(text_concat("SEQUENCE STEP - Missing action and/or window search for ", this.name, ", type : " this.type), true)
		}
	}
}