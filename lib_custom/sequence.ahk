handle_sequence() {
	sequences := get_sequences()
	if(!sequences || sequences.length() == 0 || CYCLE_DATA.hasEngineWorked) {
		return
	}
	CYCLE_DATA.hasEngineWorked := true

	sequence := get_first_sequence()
	if(sequence.hasEnded) {
		remove_first_sequence()
	} else {
		sequence.play()
		set_first_sequence(sequence)
	}
}

get_sequences() {
	return CYCLE_DATA.sequences
}
set_sequences(sequences) {
	CYCLE_DATA.sequences := sequences
}

get_first_sequence() {
	return array_first(CYCLE_DATA.sequences)
}
set_first_sequence(sequence) {
	sequences := get_sequences()
	sequences[1] := sequence
	set_sequences(sequences)
}


add_sequence(sequence) {
	sequences := get_sequences()
	sequences.push(sequence)
	set_sequences(sequences)
}

remove_first_sequence() {
	sequences := get_sequences()
	sequences := array_removeFirst(sequences)
	set_sequences(sequences)
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

	removeFirstStep() {
		this.steps := array_removeFirst(this.steps)
	}

	end() {
		this.hasEnded := true
		log.add(text_concat("SEQUENCE ", this.name, " has ended"))
	}
}