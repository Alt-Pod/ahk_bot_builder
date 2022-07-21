store_erase() {
	CYCLE_DATA.store := new Store("app")
}
store_set_value(key, value) {
	store := store_get()
	store.setValue(key, value)
	store_set(store)
}
store_save_value(key) {
	store := store_get()
	store.save(key)
	store_set(store)
}
store_delete_value(key) {
	store := store_get()
	store.delete(key)
	store_set(store)
}
store_get_value(key) {
	store := store_get()
	return store.getValue(key)
}
store_get() {
	return CYCLE_DATA.store
}
store_set(store) {
	CYCLE_DATA.store := store
}

class Store {
	__New(fileName) {
		filePath = %A_ScriptDir%\lib_custom\session\%fileName%.json
		this.filePath := filePath
		this.session := {}

		if(!FileExist(this.filePath)) {
			file := Jxon_Dump({})
			FileAppend , %file%, %filePath%
		}

		this.loadSession()
	}

	setValue(key, value) {
		session := this.session
		session[key] := value
		this.session := session
	}

	getValue(key) {
		return this.session[key]
	}

	save(key) {
		filePath := this.filePath
		value := {}
		value[key] := this.session[key]
		fileSession := map_assign(this.getSessionFileHash(), value)
		file := Jxon_Dump(fileSession)
		FileDelete, %filePath%
		FileAppend , %file%, %filePath%
	}

	delete(key) {
		filePath := this.filePath
		this.session := map_remove(this.session, [key])
		fileSession := map_assign(this.getSessionFileHash(), value)
		fileSession := map_remove(fileSession, [key])
		file := Jxon_Dump(fileSession)
		FileAppend , %file%, %filePath%
	}

	getSessionFile() {
		path := this.filePath
		FileRead, file, %path%
		return file
	}

	getSessionFileHash() {
		file := this.getSessionFile()
		return Jxon_Load(file)
	}

	loadSession() {
		this.session := map_assign(this.session, this.getSessionFileHash())
	}
}