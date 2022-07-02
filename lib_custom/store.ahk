erase_store() {
	CYCLE_DATA.store := {}
}

upsert_values_to_store(values) {
	CYCLE_DATA.store := map_assign(CYCLE_DATA.store, values)
}

get_value_from_store(key) {
	store := CYCLE_DATA.store
	return store[key]
}

store_contains_values(values) {
	return map_contains(CYCLE_DATA.store, values)
}