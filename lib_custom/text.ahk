write(text) {
	CYCLE_DATA.textToWrite := text
}

handle_writing() {
	text := CYCLE_DATA.textToWrite
	if(text == "" || CYCLE_DATA.hasEngineWorked) {
		return
	}
	CYCLE_DATA.hasEngineWorked := true
	CYCLE_DATA.textToWrite := SubStr(text, 2 , StrLen(text))
	text(SubStr(text, 1 , 1))
}