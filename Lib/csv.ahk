csv_create(path, headers) {
	headersLine := csv_arrToLine(headers, true)
	FileAppend, %headersLine%, %path%
}

csv_arrToLine(arr, headers = false) {
	content := ""
	Loop % arr.length() {
		value := arr[A_Index]
		content = %content%"%value%"
		if(A_Index != arr.length()) {
			content = %content%,
		}
	}
	if(!headers) {
		content = `n%content%`
	}
	return content
}

csv_LineToArr(line) {
	lineArr := StrSplit(line, ",")
	result := []
	Loop % lineArr.length() {
		currentLineValue := lineArr[A_Index]
		stringLengthTrimmed := StrLen(currentLineValue) - 2
		result.push(SubStr(currentLineValue, 2, stringLengthTrimmed))
	}
	return result
}

csv_getLine(path, lineIndex) {
	FileReadLine, result, %path%, %lineIndex%
	return csv_LineToArr(result)
}

csv_addLine(path, line) {
	newLine := csv_arrToLine(line)
	FileAppend, %newLine%, %path%
}

csv_nbLine(path) {
	Loop, Read, %path%
	{
	   total_lines := A_Index
	}
	return total_lines
}

csv_getOrderedArrayFromObject(path, obj) {
	headers := csv_getLine(path, 1)
	result := []
	Loop % headers.length() {
		result[A_index] := obj[headers[A_Index]]
	}
	return result
}

csv_getObject(path) {
	result := []
	nbOfLines := csv_nbLine(path)
	headers := csv_getLine(path, 1)
	Loop % nbOfLines {
		if(A_Index != 1) {
			obj := {}
			values := csv_getLine(path, A_Index)
			Loop % headers.length() {
				obj[headers[A_Index]] := values[A_Index]
			}
			result.push(obj)
		}
	}
	return result
}


csv_updateLine(path, matchingAttributes, newValues) {
	headers := csv_getLine(path, 1)
	csvList := csv_getObject(path)
	result := []
	Loop % csvList.length() {
		currentLine := csvList[A_Index]
		nbAttributes := 0
		nbAttributeMatch := 0
		for x, y in matchingAttributes {
			nbAttributes := nbAttributes + 1
			if(currentLine[x] == y) {
				nbAttributeMatch := nbAttributeMatch + 1
			}
		}
		if(nbAttributes != nbAttributeMatch) {
			result.push(csv_getOrderedArrayFromObject(path, currentLine))
		} else {
			updatedLine := currentLine
			updatedLine := map_assign(updatedLine, newValues)
			if(map_getKeys(currentLine).length() != map_getKeys(updatedLine).length()) {
				MsgBox, the bot tried to udpdate the csv %path% but the values don't match the csv's header
			}
			result.push(csv_getOrderedArrayFromObject(path, updatedLine))
		}
	}
	FileDelete, %path%
	csv_create(path, headers)
	Loop % result.length() {
		csv_addLine(path, result[A_Index])
	}
}

csv_deleteLines(path, matchingAttributes) {
	headers := csv_getLine(path, 1)
	csvList := csv_getObject(path)
	result := []
	actionsCount := 0
	Loop % csvList.length() {
		currentLine := csvList[A_Index]
		nbAttributes := 0
		nbAttributeMatch := 0
		for x, y in matchingAttributes {
			nbAttributes := nbAttributes + 1
			if(currentLine[x] == y) {
				nbAttributeMatch := nbAttributeMatch + 1
			}
		}
		if(nbAttributes != nbAttributeMatch) {
			result.push(csv_getOrderedArrayFromObject(path, currentLine))
		} else {
			actionsCount := actionsCount + 1
		}
	}
	FileDelete, %path%
	csv_create(path, headers)
	Loop % result.length() {
		csv_addLine(path, result[A_Index])
	}
	return actionsCount
}