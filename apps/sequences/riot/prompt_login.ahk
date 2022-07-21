global hasSequenceRiotLoginPrompStarted := false
global sequenceRiotLoginCredentialChoice := false
global sequenceRiotLoginAskForCredentialsRegister := false
global sequenceRiotLoginAskForCredentialsRegisterPassword := false

sequenceRiotLoginPromp() {
	if(hasSequenceRiotLoginPrompStarted) {
		return
	}
	hasSequenceRiotLoginPrompStarted := true
	
	sequence := new Sequence("Riot prompt login")

	sequence.addStep(new SequenceStep(SEQUENCE_STEP_TYPE.EMPTY, "askForCredentials", false, false, { callback: func("sequenceRiotLoginAskForCredentials") } ))

	add_sequence(sequence)
}

sequenceRiotLoginPrompReset() {
	hasSequenceRiotLoginPrompStarted := false
}

sequenceRiotLoginAskForCredentials() {
	riotCredentials := store_get_value("riotCredentials")
	if(!riotCredentials) {
		store_set_value("riotCredentials", [])
	}
	inputs := []
	Loop % riotCredentials.length() {
		inputs.push(riotCredentials[A_Index].RIOT_LOGIN)
	}
	prompt := new PromptUI("Choose your credentials", A_ScreenWidth/2, A_ScreenHeight/2)
	prompt.addText("Choose your login :")
	prompt.addSelect("sequenceRiotLoginCredentialChoice", inputs)
	prompt.addButton("sequenceRiotLoginAskForCredentialsConnect","Connect")
	prompt.addButton("sequenceRiotLoginAskForCredentialsDelete","Delete")
	prompt.addText("Enter your username")
	prompt.addInputText("sequenceRiotLoginAskForCredentialsRegister")
	prompt.addText("Enter your password")
	prompt.addInputText("sequenceRiotLoginAskForCredentialsRegisterPassword")
	prompt.addButton("sequenceRiotLoginAskForCredentialsSave","Save credentials")

	prompt.breakLine()
	set_prompt_mod(prompt)
}

sequenceRiotLoginAskForCredentialsDelete() {
	submit_prompt()
	end_prompt_mode()
	riotCredentials := store_get_value("riotCredentials")
	newRiotCredentials := []
	Loop % riotCredentials.length() {
		if(riotCredentials[A_Index].RIOT_LOGIN != sequenceRiotLoginCredentialChoice) {
			newRiotCredentials.push(riotCredentials[A_Index])
		}
	}
	store_set_value("riotCredentials", newRiotCredentials)
	store_save_value("riotCredentials")
	remove_all_sequences()
	sequenceRiotLoginAskForCredentials()
}

sequenceRiotLoginAskForCredentialsConnect() {
	submit_prompt()
	end_prompt_mode()
	riotCredentials := store_get_value("riotCredentials")
	loginCredentials := array_mapFind(riotCredentials, { RIOT_LOGIN: sequenceRiotLoginCredentialChoice })
	store_set_value("loginCredentials", loginCredentials)
	sequenceRiotLogin()
}

sequenceRiotLoginAskForCredentialsSave() {
	submit_prompt()
	end_prompt_mode()
	riotCredentials := store_get_value("riotCredentials")
	riotCredentials.push({ RIOT_LOGIN: sequenceRiotLoginAskForCredentialsRegister, RIOT_PASSWORD: sequenceRiotLoginAskForCredentialsRegisterPassword })
	store_set_value("riotCredentials", riotCredentials)
	store_save_value("riotCredentials")
	remove_all_sequences()
	sequenceRiotLoginAskForCredentials()
}