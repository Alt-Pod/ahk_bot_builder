#Include %A_ScriptDir%/apps/sequences/riot_login.ahk

global appLolTrollModHasRiotLaunched := false

appLolTrollMod() {

	lolClientName = League of Legends

	riot := new Program(riotName, riotProcess)

}

appLolTrollModHandleRiot() {
	riotName = Riot Client
	riotProcess = C:\Riot Games\Riot Client\RiotClientServices.exe

	if(!appLolTrollModHasRiotLaunched) {
		riot.start()
		appLolTrollModHasRiotLaunched := true
	}
	riot.activate()
	sequenceRiotLogin()
}