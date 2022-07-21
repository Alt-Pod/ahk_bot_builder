global hasSequenceLolClientLaunchAramStarted := false

sequenceLolClientLaunchAram() {
	if(hasSequenceLolClientLaunchAramStarted) {
		return
	}
	hasSequenceLolClientLaunchAramStarted := true

}