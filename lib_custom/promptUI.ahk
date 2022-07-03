handle_prompt() {
	prompt := CYCLE_DATA.promptMod
	if(CYCLE_DATA.hasEngineWorked || !prompt|| prompt.done) {
		return
	}
	CYCLE_DATA.hasEngineWorked := true
	prompt.show()
	CYCLE_DATA.promptMod := prompt
}

set_prompt_mod(prompt) {
	CYCLE_DATA.promptMod := prompt
}

remove_prompt_mod() {
	CYCLE_DATA.promptMod := null
}

end_prompt_mode() {
	prompt := CYCLE_DATA.promptMod
	if(!prompt) {
		return
	}
	Sleep, 100
	prompt.end()
	Sleep, 100
	CYCLE_DATA.promptMod := prompt
}

submit_prompt() {
	prompt := CYCLE_DATA.promptMod
	if(!prompt) {
		return
	}
	Sleep, 100
	prompt.submit()
	Sleep, 100
	CYCLE_DATA.promptMod := prompt
}

exitApp() {
	ExitApp
}

resetApp() {
	Reload
}

class PromptUI {
	__New(title = "undefined", windowWidth = false, windowHeight = false) {
		this.title := title
		this.done := false
		if(windowWidth) {
			this.windowWidth := windowWidth
		} else {
			this.windowWidth := A_ScreenWidth
		}
		if(windowHeight) {
			this.windowHeight := windowHeight
		} else {
			this.windowHeight := A_ScreenHeight
		}
		Gui, Font, s12
	}

	show() {
		if(this.hasShown) {
			return
		}
		this.hasShown := true
		windowWidth := this.windowWidth
		windowHeight := this.windowHeight
		offsetX := (A_ScreenWidth - windowWidth)/2
		offsetY := (A_ScreenHeight - windowHeight)/2
		title := this.title
		this.breakLine()
		this.addResetButton()
		this.addExitButton()
		log.add(text_concat("PROMPT - Opened prompt with title : '", title, "'"))
		Gui, Show, w%windowWidth% h%windowHeight% x%offsetX% y%offsetY%, %title%
	}

	addText(text) {
		Gui, Add, Text,, %text%
	}

	addInputText(globalVarName) {
		Gui, Add, Edit, v%globalVarName%
	}

	addButton(callback, text) {
		Gui, Add, Button, g%callback%, %text%
	}

	addExitButton() {
		this.addButton("exitApp", "EXIT")
	}

	addResetButton() {
		this.addButton("resetApp", "RESTART APP")
	}

	breakLine() {
		Gui, Add, Text,,
	}

	submit() {
		Gui Submit
		this.end()
	}
 
	end() {
		this.done := true
		Gui Destroy
	}
}