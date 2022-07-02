#Include %A_ScriptDir%\apps\screen_capture\app.ahk

app() {
	if(get_prompt_mod() == promptMod.SCREEN_CAPTURE_MOD) {
		appScreenCapture()
	}
}