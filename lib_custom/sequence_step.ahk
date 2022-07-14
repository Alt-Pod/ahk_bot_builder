global SEQUENCE_STEP_TYPE := { WAIT_FOR_SCREEN: "WAIT_FOR_SCREEN"
	, ACTION: "ACTION"
	, SCREEN_CALLBACK: "SCREEN_CALLBACK"
	, SCREEN_FAILURE_ACTION: "SCREEN_FAILURE_ACTION"
	, SCREEN_FAILURE_STEP: "SCREEN_FAILURE_STEP"
	, EMPTY: "EMPTY"
	, MULTIPLE_SCREEN_CALLBACK: "MULTIPLE_SCREEN_CALLBACK"
	, READ_TEXT: "READ_TEXT" }

build_sequence_step(step) {
	return new SequenceStep(step.type, step.name, step.windowSearch, step.action, step.options)
}

sequence_add_step_first(step) {
	if(!step) {
		log.add("A sequence add step first was launched but no step was found", true)
	}
	sequence := get_first_sequence()
	sequence.addStepFirst(step)
	set_first_sequence(sequence)
}

sequence_add_step_second(step) {
	if(!step) {
		log.add("A sequence add step first was launched but no step was found", true)
	}
	sequence := get_first_sequence()
	sequence.addStepFirst(step)
	set_first_sequence(sequence)
}

sequence_duplicate_step(step) {
	sequence := get_first_sequence()
	targetStep := build_sequence_step(step)
	targetStep.chainedStep := false
	targetStep.repeatedStep := false
	targetStep.callback := false
	targetStep.options := false
	if(!targetStep) {
		log.add("A duplicated target step wasnt found in sequence", true)
	}
	sequence.addStepFirst(targetStep)
	set_first_sequence(sequence)
}

sequence_add_step_first_as_action(payload) {
	if(!payload || !payload.action) {
		log.add("A sequence add step first as action was launched but no action was found", true)
	}
	action := payload.action
	sequenceStep := new SequenceStep(SEQUENCE_STEP_TYPE.ACTION, action.name, false,  action)
	sequence_add_step_first(sequenceStep)
}

remove_sequence_step_by_id(payload) {
	if(!payload || !payload.stepIdToBeRemoved) {
		log.add("A remove sequence step by id operation was launched but no id for step was found", true)
	}

	id := payload.stepIdToBeRemoved
	sequence := get_first_sequence()
	sequence.removeStep(id)
	set_first_sequence(sequence)
}

remove_first_sequence_step() {
	sequence := get_first_sequence()
	sequence.removeFirstStep()
	set_first_sequence(sequence)
}

handle_failure_sequence_step(payload) {
	if(!payload || !payload.failureStep) {
		log.add("A sequence add step first as failure step was launched but no step was found", true)
	}
	sequence_add_step_first(payload.failureStep)
}

handle_success_read_text(payload, result) {
	successCallBack := payload.successCallBack
	if(!payload || !result || !result.text || !successCallBack) {
		log.add("A sequence read text step success was launched but no text or successCallBack was found", true)
	}
	%successCallBack%(result)
	remove_sequence_step_by_id(payload)
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
		if(options && options.successCallBack) {
			this.successCallBack := options.successCallBack
		}
		if(options && options.failureStep) {
			this.failureStep := build_sequence_step(options.failureStep)
		}
		if(options && options.repeatedStep) {
			this.repeatedStep := options.repeatedStep
		}
		if(options && options.callback) {
			this.callback := options.callback
		}

		this.handleError()
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
		if(this.type == SEQUENCE_STEP_TYPE.SCREEN_FAILURE_STEP) {
			this.runScreenFailureStep()
		}
		if(this.type == SEQUENCE_STEP_TYPE.SCREEN_CALLBACK) {
			this.runScreenCallback()
		}
		if(this.type == SEQUENCE_STEP_TYPE.EMPTY) {
			this.isFinished := true
		}
		if(this.type == SEQUENCE_STEP_TYPE.MULTIPLE_SCREEN_CALLBACK) {
			this.runScreenMultipleCallback()
		}
		if(this.type == SEQUENCE_STEP_TYPE.READ_TEXT) {
			this.runScreenReadText()
		}
		this.runChainedStep()
		this.runRepeatedStep()
		this.runCallback()
	}

	runChainedStep() {
		chainedStep := this.chainedStep
		if(!chainedStep) {
			return
		}
		this.chainedStep := false
		sequence_add_step_second(chainedStep)
	}

	runRepeatedStep() {
		if(!this.repeatedStep) {
			return
		}
		nbRepeact := this.repeatedStep
		this.repeatedStep := false
		Loop % nbRepeact {
			sequence_duplicate_step(this)
		}
	}

	runScreenCallback() {
		success := this.options.successCallBack
		failure := this.options.failureCallBack
		add_window_search_to_ui_scan(this.windowSearch
			, success
			, failure
			, this.buildCallbackPayload(this.windowSearch) )
	}

	runScreenFailureAction() {
		add_window_search_to_ui_scan(this.windowSearch
			, func("remove_sequence_step_by_id")
			, func("sequence_add_step_first_as_action")
			, { action: this.action, stepIdToBeRemoved: this.id })
	}

	runScreenFailureStep() {
		add_window_search_to_ui_scan(this.windowSearch
			, func("remove_sequence_step_by_id")
			, func("handle_failure_sequence_step")
			, { failureStep: this.failureStep, stepIdToBeRemoved: this.id })
	}

	runAction() {
		add_action(this.action)
		this.isFinished := true
	}

	runWaitForScreen() {
		add_window_search_to_ui_scan(this.windowSearch
			, func("remove_sequence_step_by_id")
			, func("nothing")
			, { stepIdToBeRemoved: this.id })
	}

	runScreenReadText() {
		add_window_search_to_ui_scan(this.windowSearch
			, func("handle_success_read_text")
			, func("nothing")
			, { successCallBack: this.successCallBack, stepIdToBeRemoved: this.id })
	}

	runCallback() {
		callback := this.callback
		if(!callback) {
			return
		}
		%callback%()
		this.callback := false
	}

	runScreenMultipleCallback() {
		success := this.options.successCallBack
		failure := this.options.failureCallBack
		Loop % this.options.screenCollection.length() {
			add_window_search_to_ui_scan(this.options.screenCollection[A_Index]
				, success
				, failure
				, this.buildCallbackPayload(this.options.screenCollection[A_Index]) )
		}
	}

	handleError() {
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
		if(this.type == SEQUENCE_STEP_TYPE.SCREEN_FAILURE_STEP && (!this.windowSearch || !this.options|| !this.options.failureStep)) {
			log.add(text_concat("SEQUENCE STEP - Missing action/windowSearch/options for ", this.name, ", type : " this.type), true)
		}
		if(this.type == SEQUENCE_STEP_TYPE.MULTIPLE_SCREEN_CALLBACK && (!this.options || !this.options.screenCollection || !this.options.successCallBack || !this.options.failureCallBack)) {
			log.add(text_concat("SEQUENCE STEP - Missing action/windowSearch/options for ", this.name, ", type : " this.type), true)
		}
		if(this.type == SEQUENCE_STEP_TYPE.READ_TEXT && (!this.options || !this.options.successCallBack)) {
			log.add(text_concat("SEQUENCE STEP - Missing options for ", this.name, ", type : " this.type), true)
		}
	}

	buildCallbackPayload(windowSearch = false) {
		result := { name: this.name, type: this.type }
		if(windowSearch) {
			result := map_assign({ windowSearchName: windowSearch.name }, result)
		}
		if(!this.options) {
			return result
		}
		return map_assign(this.options, result)
	}
}