exit_withKey(exitKey)  {
	exitKey := GetKeyState(exitKey)
	if(exitKey){
		ExitApp
	}
}