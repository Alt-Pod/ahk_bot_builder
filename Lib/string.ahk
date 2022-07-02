string_contains(string, value) {
	IfInString, string, %value%
	{
		return true
	}
	return false
}

string_isANumber(string) {
	numbers := ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
	Loop, Parse, string 
	{
		if(!array_contains(numbers, A_LoopField)){
			return false
		}
	}
	return true
}

string_lower(text) {
	StringLower, OutputVar, text
	return OutputVar
}

string_toHex(string) {
	strArr := StrSplit(string, "x")
	if(!strArr[2]) {
		return "undefined"
	}
	value := strArr[2]
	result = 0x%value%
	return result
}