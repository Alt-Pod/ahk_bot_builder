global hasStartedPromptMenu := false
global hasClosedPromptMenu := false
global promptMod := { SCREEN_CAPTURE_MOD: "SCREEN_CAPTURE_MOD"
	, AOE2_DE: "AOE2_DE"}

handle_prompt() {
	if(CYCLE_DATA.hasEngineWorked || CYCLE_DATA.hasPrompted) {
		return
	}
	if(!CYCLE_DATA.hasPrompted) {
		CYCLE_DATA.hasEngineWorked := true
	}
	if(!hasStartedPromptMenu) {
		openPromptMenu("Please pick a mod for the bot")
		hasStartedPromptMenu := true
	}
}

get_prompt_mod() {
	return CYCLE_DATA.botMod
}

set_prompt_mod(value) {
	CYCLE_DATA.botMod := value
	CYCLE_DATA.hasPrompted := true
	closePromptMenu()
}

openPromptMenu(title) {
	windowWidth := A_ScreenWidth/3
	windowHeight := A_ScreenHeight/3

	Gui, Font, s12
	Gui, Add, Button, gButtonScreenCaptureMod, LAUNCH SCREEN CAPTURE MOD
	Gui, Add, Button, gButtonAoe2DEMod, LAUNCH AOE2 DE MOD
	Gui, Add, Text,,
	Gui, Add, Button, gQuitApp, EXIT
	Gui, Show, w%windowWidth% h%windowHeight% x%windowWidth% y%windowHeight%, %title%
}

QuitApp() {
	ExitApp
}

closePromptMenu() {
	Gui Destroy
}

ButtonScreenCaptureMod() {
	set_prompt_mod(promptMod.SCREEN_CAPTURE_MOD)
}

ButtonAoe2DEMod() {
	set_prompt_mod(promptMod.AOE2_DE)
}