pause(sleepTime) {
	CYCLE_DATA.sleepTime := sleepTime
}

handle_pause() {
	sleepTime := CYCLE_DATA.sleepTime
	if(sleepTime < 1 || CYCLE_DATA.hasEngineWorked) {
		return
	}
	CYCLE_DATA.hasEngineWorked := true
	if(sleepTime > 100) {
		Sleep, 100
		CYCLE_DATA.sleepTime := sleepTime - 100
	} else {
		Sleep, %sleepTime%
		CYCLE_DATA.sleepTime := 0
	}
}