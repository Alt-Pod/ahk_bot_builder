#Include %A_ScriptDir%\apps\src\screen_capture\app.ahk
#Include %A_ScriptDir%\apps\src\menu\app.ahk
#Include %A_ScriptDir%\apps\src\lol_troll_mod\app.ahk

app() {
	appMod := store_get_value("appMod")
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