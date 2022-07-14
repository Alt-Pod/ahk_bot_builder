#Include %A_ScriptDir%/apps/sequences/riot_login.ahk
#Include %A_ScriptDir%/apps/sequences/lol_client_launch_aram.ahk

appLolTrollMod() {
	client := appLolTrollModGetLolClient()
	riot := appLolTrollModGetRiotClient()
	if(client.isOpen()) {
		appLolTrollModHandleClient(client, riot)
	} else {
		appLolTrollModHandleRiot(riot)
	}
}

appLolTrollModHandleRiot(riot) {
	riot.start()
	riot.activate()
	sequenceRiotLogin()
}

appLolTrollModHandleClient(client, riot) {
	if(riot.isOpen()) {
		riot.end()
		return
	}
	client.activate()
	sequenceLolClientLaunchAram()
}

appLolTrollModGetRiotClient() {
	riotName = Riot Client
	riotProcess = C:\Riot Games\Riot Client\RiotClientServices.exe
	return new Program(riotName, riotProcess)
}

appLolTrollModGetLolClient() {
	clientName = League of Legends
	clientProcess = C:\Riot Games\League of Legends\LeagueClient.exe
	return new Program(clientName, clientProcess)
}