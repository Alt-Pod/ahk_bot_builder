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

close_program(programProcessName) {
	WinKill, %programProcessName%
}

class Program {
	__New(processName, processLocation) {
		this.processName := processName
		this.processLocation := processLocation
		this.hasStarted := false
	}

	start() {
		if(!program_exists(this.processName) && !this.hasStarted) {
			launch_program(this.processLocation)
			this.hasStarted := true
		} else {
			this.activate()
		}
	}

	isOpen() {
		return is_window_open(this.processName)
	}

	activate() {
		if(is_window_open(this.processName)) {
			activate_window(this.processName)
		}
	}

	uiScan(windowSearch) {
		CYCLE_DATA.uiScan := windowSearch
	}

	end() {
		if(program_exists(this.processName)) {
			close_program(this.processName)
		}
	}
}