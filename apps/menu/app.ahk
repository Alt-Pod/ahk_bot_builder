global PROMPT_MODE := { SCREEN_CAPTURE_MOD: "SCREEN_CAPTURE_MOD" }

appMenu() {
	prompt := new PromptUI("Choose your bot mod", A_ScreenWidth/2, A_ScreenHeight/2)
	prompt.addButton("ButtonScreenCaptureMod", "LAUNCH SCREEN CAPTURE MOD")
	prompt.breakLine()
	set_prompt_mod(prompt)
}

ButtonScreenCaptureMod() {
	upsert_values_to_store({ appMod: PROMPT_MODE.SCREEN_CAPTURE_MOD })
	end_prompt_mode()
}