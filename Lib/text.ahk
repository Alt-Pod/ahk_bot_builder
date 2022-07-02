text(value) {
	Send %value%
}

text_alert(value) {
	MsgBox % value
}

text_tooltip(value) {
	ToolTip % value
}

text_errorMsgBoxMap(obj) {
	content = MAP ANALYSIS : `n`
	keys := map_getKeys(obj)
	Loop % keys.length() {
		key := keys[A_Index]
		value := obj[key]
		content = %content%%key% - %value% `n`
	}
	MsgBox % content
}

text_errorTooltipMap(obj) {
	content = MAP ANALYSIS : `n`
	keys := map_getKeys(obj)
	Loop % keys.length() {
		key := keys[A_Index]
		value := obj[key]
		content = %content%%key% - %value% `n`
	}
	ToolTip % content
}

text_concat(text1, text2, text3 = "", text4 = "", text5 = "", text6 = "", text7 = "", text8 = "", text9 = "", text10 = "", text11 = "", text12 = "") {
	concatenation = %text1%%text2%%text3%%text4%%text5%%text6%%text7%%text8%%text9%%text10%%text11%%text12%
	return concatenation
}