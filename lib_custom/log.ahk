 class Log {
	__New() {
		this.hasCreatedLogFile := false
	}

	createLogFile() {
		dir = %A_ScriptDir%\logs\
		fileName := this.getFileName()
		path = %dir%%fileName%
		this.currentLogFile := path
		FileAppend,
		(
		), %path%
	}

	getFileName() {
		date := date_reversed()
		clock := time_clock()
		fileName = %date%_%clock%.txt
		return fileName
	}

	add(text, error = false) {
		if(!this.hasCreatedLogFile) {
			this.createLogFile()
			this.hasCreatedLogFile := true
		}
		path := this.currentLogFile
		clock := time_clock_logformat()
		prefix = [%clock%]
		content = %prefix%%text%
		if(error) {
			prefix = %prefix%[ERROR]
			content = %prefix% %text%
		}
		FileAppend,
		(
			%content%

		), %path%
		if(error) {
			MsgBox % text
		}
	}
} 