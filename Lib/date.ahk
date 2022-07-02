date_get() {
	date = %A_DD%-%A_MM%-%A_YYYY%
	return date
}

date_reversed() {
	date = %A_YYYY%-%A_MM%-%A_DD%
	return date
}

date_timestamp() {
	date := date_reversed()
	time = %A_Hour%:%A_Min%:%A_Sec%
	timestamp = %date% %time%
	return timestamp
}