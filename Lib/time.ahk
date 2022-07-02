time_get() {
	return A_TickCount
}

time_diff(t1, t2) {
	return t2 - t1
}

time_sec(t) {
	return t/1000
}

time_format(t) {
	min := Floor(time_sec(t)/60)
	sec := Floor(time_sec(t)-min*60)
	minFormatted := ""
	secFormatted := ""
	if (min < 10) {
		minFormatted := "0"
	}
	if (sec < 10) {
		secFormatted := "0"
	}
	minFormatted = %minFormatted%%min%:%secFormatted%%sec%
	return minFormatted
}

time_out(time, timeout) {
	if(!time or time_sec(time_diff(time, time_get())) > timeout) {
		return true
	}
	return false
}

time_clock() {
	clock = %A_Hour%-%A_Min%-%A_Sec%
	return clock
}

time_clock_logformat() {
	clock = %A_Hour%:%A_Min%:%A_Sec%
	return clock
}