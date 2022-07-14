global hasAppLaunchedReload := false

reloadApp() {
	if(hasAppLaunchedReload) {
		return
	}
	hasAppLaunchedReload := true
	Reload
}