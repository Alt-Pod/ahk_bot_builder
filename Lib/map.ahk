map_getKeys(map) {
	keys := []
	for x in map {
		keys.push(x)
	}
	return keys
}

map_copy(obj) {
	result := {}
	for x, y in obj {
		result[x] := y
	}
	return result
}

map_assign(obj, attributes) {
	map := map_copy(obj)
	for x, y in attributes {
		map[x] := y
	}
	return map
}

map_hasKey(map, key) {
	keys := map_getKeys(map)
	return array_contains(keys, key)
}

map_equals(map1, map2) {
	for x, y in map1 {
		if(map2[x] != y) {
			return false
		}
	}
	return true
}

map_contains(map, attributes) {
	for x, y in attributes {
		if(map[x] != y) {
			return false
		}
	}
	return true
}

map_remove(map, keys) {
	newMap := {}
	for x, y in map {
		toBeAdded := true
		Loop % keys.length() {
			key := keys[A_Index]
			if(x == key) {
				toBeAdded := false
			}
		}
		if(toBeAdded) {
			newMap[x] := y
		}
	}
	return newMap
}

map_isMap(parameter) {
	if(map_getKeys(parameter).length() > 0) {
		return true
	}
	return false
}