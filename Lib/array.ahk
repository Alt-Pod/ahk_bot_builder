array_contains(array, item) {
	result := false
	if(!array) {
		return result
	}
	Loop % array.length() {
		if(array[A_Index] == item) {
			result := true
			break
		}
	}
	return result
}

array_compare(array1, array2) {
	Loop % array1.length() {
		if(!array_contains(array2, array1[A_Index])) {
			result := false
			break
		}
	}
	return true
}

array_reverse(array) {
	newArray := []
	Loop % array.length() {
		newArray.push(array[array.length() - A_Index + 1])
	}
	return newArray
}

array_mapFind(arrayMap, matchingExpression) {
	result := ""
	Loop % arrayMap.length() {
		currentMap := arrayMap[A_Index]
		found := true
		for x, y in matchingExpression {
			if(currentMap[x] != y) {
				found := false
				break
			}
		}
		if(found) {
			result := currentMap
			break
		}
	}
	return result
}

array_mapRemoveAll(arrayMap, matchingExpression) {
	result := []
	Loop % arrayMap.length() {
		nbAttributes := 0
		nbAttributeMatch := 0
		currentMap := arrayMap[A_Index]
		for x, y in matchingExpression {
			nbAttributes := nbAttributes + 1
			if(currentMap[x] == y) {
				nbAttributeMatch := nbAttributeMatch + 1
			}
		}
		if(nbAttributes != nbAttributeMatch) {
			result.push(currentMap)
		}
	}
	return result
}

array_mapFilter(arrayMap, matchingExpression) {
	result := []
	Loop % arrayMap.length() {
		toBePushed := true
		currentMap := arrayMap[A_Index]
		for x, y in matchingExpression {
			if(currentMap[x] != y) {
				toBePushed := false
			}
		}
		if(toBePushed) {
			result.push(currentMap)
		}
	}
	return result
}

array_mapMap(arrayMap, property) {
	result := []
	Loop % arrayMap.length() {
		result.push(arrayMap[A_Index][property])
	}
	return result
}

array_toString(array) {
	string := ""
	Loop % array.length() {
		val := array[A_Index]
		string = %string%%val%
	}
	return string
}

array_toInPutFormat(array) {
	string := ""
	Loop % array.length() {
		val := array[A_Index]
		string = %string%%val%
		if(A_Index != array.length()) {
			string = %string%|
		}
	}
	return string
}

array_removeItem(array, item, single = false) {
	newArray := []
	found := false
	Loop % array.length() {
		if(!single) {
			if(array[A_Index] != item) {
				newArray.push(array[A_Index])
			}
		} else {
			if(array[A_Index] == item && !found) {
				found := true
			} else {
				newArray.push(array[A_Index])
			}
		}
	}
	return newArray
}

array_substract(arr1, arr2) {
	if(!arr2) {
		return arr1
	}
	filteredItems := array_copy(arr1)
	Loop % arr2.length() {
		filteredItems := array_removeItem(filteredItems, arr2[A_Index], true)
	}
	return filteredItems
}

array_concat(arr1, arr2) {
	concatenedArray := array_copy(arr1)
	if(!arr2 or arr2.length() == 0) {
		return arr1
	}
	Loop % arr2.length() {
		concatenedArray.push(arr2[A_Index])
	}
	return concatenedArray
}

array_removeFirst(arr) {
	newArr := []
	Loop % arr.length() {
		if(A_Index > 1) {
			newArr.push(arr[A_Index])
		}
	}
	return newArr
}

array_removeLast(arr) {
	newArr := []
	arrayLength := arr.length()
	Loop % arrayLength {
		if(A_Index < arrayLength) {
			newArr.push(arr[A_Index])
		}
	}
	return newArr
}

array_copy(arr) {
	result := []
	Loop % arr.length() {
		result.push(arr[A_Index])
	}
	return result
}

array_order(arr) {
	result := []
	Loop % arr.length() {
		currentValue := arr[A_Index]
		Loop % arr.length() {
			if(array_contains(result, currentValue) && !array_contains(result, arr[A_Index])) {
				currentValue := arr[A_Index]
			}
			if(currentValue > arr[A_Index] && !array_contains(result, arr[A_Index])) {
				currentValue := arr[A_Index]
			}
		}
		result.push(currentValue)
	}
	return result
}

array_max(arr) {
	result := arr[1]
	Loop % arr.length() {
		if(arr[A_Index] > result) {
			result := arr[A_Index]
		}
	}
	return result
}

array_index(arr, value) {
	index := -1
	Loop % arr.length() {
		if(Round(arr[A_Index], 4) == Round(value, 4)) {
			MsgBox % arr[A_Index]
			MsgBox % value
			text_errorMsgBoxMap(arr)
			index := A_Index
		}
	}
	return index
}

array_pushFirst(array, value) {
	result := []
	result.push(value)
	Loop % array.length() {
		result.push(array[A_Index])
	}
	return result
}

array_pushSecond(array, value) {
	result := []
	Loop % array.length() {
		result.push(array[A_Index])
		if(A_Index == 1) {
			result.push(value)
		}
	}
	return result
}

array_first(array) {
	if(!array or array.length() == 0) {
		return null
	}
	return array[1]
}

array_last(array) {
	arrayLength := array.length()
	if(!array or arrayLength == 0) {
		return null
	}
	return array[arrayLength]
}