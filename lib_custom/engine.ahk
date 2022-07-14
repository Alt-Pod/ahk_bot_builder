global log := new Log()

engine() {
	CYCLE_DATA.hasEngineWorked := false

	handle_quit()
	handle_pause()
	handle_mouse_drag()
	handle_writing()
	handle_prompt()
	handle_ui_scan()
	handle_action()
	handle_sequence()
}