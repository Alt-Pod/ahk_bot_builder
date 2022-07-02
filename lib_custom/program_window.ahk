is_window_open(programProcessName) {
	return WinExist(programProcessName)
}

activate_window(programProcessName) {
	WinActivate % programProcessName
}

launch_program(path_exe) {
	run, %path_exe%
}

program_exists(programProcessName) {
	return WinExist(programProcessName)
}

class Program {
	__New(processName, processLocation) {
		this.processName := processName
		this.processLocation := processLocation
	}

	start() {
		if(!program_exists(this.processName)) {
			launch_program(this.processLocation)
		} else {
			this.activate()
		}
	}

	activate() {
		if(is_window_open(this.processName)) {
			activate_window(this.processName)
		}
	}

	uiScan(windowSearch) {
		CYCLE_DATA.uiScan := windowSearch
	}
}