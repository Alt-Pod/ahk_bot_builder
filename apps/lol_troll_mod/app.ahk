#Include %A_ScriptDir%/apps/sequences/riot_login.ahk

global appLolTrollModHasRiotLaunched := false

appLolTrollMod() {
	appLolTrollModHandleRiot()
}

appLolTrollModHandleRiot() {
	riotName = Riot Client
	riotProcess = C:\Riot Games\Riot Client\RiotClientServices.exe
	riot := new Program(riotName, riotProcess)

	if(!appLolTrollModHasRiotLaunched) {
		riot.start()
		appLolTrollModHasRiotLaunched := true
	}
	riot.activate()
	sequenceRiotLogin()
}