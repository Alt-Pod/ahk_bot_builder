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
		this.steps.push(build_sequence_step(sequenceStep)) 
	}

	addStepFirst(sequenceStep) {
		this.steps := array_pushFirst(this.steps, build_sequence_step(sequenceStep)) 
	}

	addStepSecond(sequenceStep) {
		this.steps := array_pushSecond(this.steps, build_sequence_step(sequenceStep)) 
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
	, SCREEN_FAILURE_ACTION: "SCREEN_FAILURE_ACTION"
	, SCREEN_FAILURE_STEP: "SCREEN_FAILURE_STEP" }

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

sequence_add_step_first_as_failure_step(payload) {
	if(!payload || !payload.failureStep) {
		log.add("A sequence add step first as failure step was launched but no step was found", true)
	}
	sequences := CYCLE_DATA.sequences
	sequence := array_first(sequences)

	sequence.addStepFirst(payload.failureStep)
	
	sequences := array_removeFirst(sequences)
	CYCLE_DATA.sequences := array_pushFirst(sequences, sequence)
}

sequence_add_built_step_first(step) {
	if(!step) {
		log.add("A sequence add step first was launched but no step was found", true)
	}
	sequences := CYCLE_DATA.sequences
	sequence := array_first(sequences)

	sequence.addStepFirst(step)
	
	sequences := array_removeFirst(sequences)
	CYCLE_DATA.sequences := array_pushFirst(sequences, sequence)
}

sequence_add_built_step_second(step) {
	if(!step) {
		log.add("A sequence add step second was launched but no step was found", true)
	}
	sequences := CYCLE_DATA.sequences
	sequence := array_first(sequences)

	sequence.addStepSecond(step)
	
	sequences := array_removeFirst(sequences)
	CYCLE_DATA.sequences := array_pushFirst(sequences, sequence)
}

sequence_duplicate_step(stepId) {
	sequences := CYCLE_DATA.sequences
	sequence := array_first(sequences)

	targetStep := null
	Loop % sequence.steps.length() {
		step := sequence.steps[A_Index]
		if(step.id == stepId) {
			targetStep := new SequenceStep(step.type, step.name, step.windowSearch, step.action, stepOption)
			targetStep.chainedStep := false
			targetStep.repeatedStep := false
		}
	}
	if(!targetStep) {
		log.add("A duplicated target step wasnt found in sequence", true)
	}
	sequence.addStepFirst(targetStep)
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
	sequence_add_built_step_first(sequenceStep)
}

build_sequence_step(step) {
	return new SequenceStep(step.type, step.name, step.windowSearch, step.action, step.options)
}

class SequenceStep {
	__New(type, name = "undefined", windowSearch = false, action = false, options = false) {
		this.id := random_guid()
		this.name := name
		this.type := type
		this.windowSearch := windowSearch
		this.action := action
		this.isFinished := false
		this.options := options

		if(options && options.chainedStep) {
			this.chainedStep := build_sequence_step(options.chainedStep)
		}
		if(options && options.failureStep) {
			this.failureStep := build_sequence_step(options.failureStep)
		}
		if(options && options.repeatedStep) {
			this.repeatedStep := options.repeatedStep
		}

		this.setup()
	}

	run() {
		this.runChainedStep()
		this.runRepeatedStep()
		if(this.type == SEQUENCE_STEP_TYPE.WAIT_FOR_SCREEN) {
			this.runWaitForScreen()
		}
		if(this.type == SEQUENCE_STEP_TYPE.ACTION) {
			this.runAction()
		}
		if(this.type == SEQUENCE_STEP_TYPE.SCREEN_FAILURE_ACTION) {
			this.runScreenFailureAction()
		}
		if(this.type == SEQUENCE_STEP_TYPE.SCREEN_FAILURE_STEP) {
			this.runScreenFailureStep()
		}
	}

	runScreenFailureAction() {
		add_window_search_to_ui_scan(this.windowSearch
			, func("remove_sequence_step_from_sequence")
			, func("sequence_add_step_first_as_action")
			, { action: this.action, stepIdToBeRemoved: this.id })
	}

	runScreenFailureStep() {
		add_window_search_to_ui_scan(this.windowSearch
			, func("remove_sequence_step_from_sequence")
			, func("sequence_add_step_first_as_failure_step")
			, { failureStep: this.failureStep, stepIdToBeRemoved: this.id })
	}

	runChainedStep() {
		chainedStep := this.chainedStep
		if(!chainedStep) {
			return
		}
		this.chainedStep := false
		sequence_add_built_step_second(chainedStep)
	}

	runRepeatedStep() {
		options := this.options
		if(!options || !options.repeatedStep) {
			return
		}
		nbRepeact := options.repeatedStep
		this.repeatedStep := false
		Loop % nbRepeact {
			sequence_duplicate_step(this.id)
		}
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

	runScreenChainedAction() {
		add_action(this.action)
		this.isFinished := true
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
		if(this.type == SEQUENCE_STEP_TYPE.SCREEN_FAILURE_ACTION && (!this.action || !this.windowSearch)) {
			log.add(text_concat("SEQUENCE STEP - Missing action and/or window search for ", this.name, ", type : " this.type), true)
		}
		if(this.type == SEQUENCE_STEP_TYPE.SCREEN_FAILURE_STEP && (!this.windowSearch || !this.options.failureStep)) {
			log.add(text_concat("SEQUENCE STEP - Missing action/windowSearch/options for ", this.name, ", type : " this.type), true)
		}
	}
}