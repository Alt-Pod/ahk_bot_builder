#Include %A_ScriptDir%\apps\screen_capture\app.ahk
#Include %A_ScriptDir%\apps\menu\app.ahk
#Include %A_ScriptDir%\apps\lol_troll_mod\app.ahk

app() {
	appMod := get_value_from_store("appMod")
	if(appMod == null) {
		appMenu()
	}
	if(appMod == PROMPT_MODE.SCREEN_CAPTURE_MOD) {
		appScreenCapture()
	}
	if(appMod == PROMPT_MODE.LOL_TROLL_MOD) {
		appLolTrollMod()
	}
}