class Screen {
	__New(screenSearchList) {
		this.current := ""
		this.screenSearchList := screenSearchList
	}

	handle() {
		if(this.current != "") {
			return
		}
		Loop % this.screenSearchList.length() {
			screenSearchElement := this.screenSearchList[A_Index]
			foundImg := this.get_success(screenSearchElement.name)
			if(foundImg) {
				this.current := foundImg
				log.add(text_concat("CURRRENT SCREEN : ", foundImg.name))
			}
			if(this.current == "") {
				screenSearchElement.search()
			}
		}
	}

	get_success(name) {
		return array_mapFind(array_reverse(CYCLE_DATA.imgSearchResults), { name: name, found: true })
	}
}

class ScreenSearchElement {
	__New(name, imgPath, zone = false) {
		this.name := name
		this.imgPath := imgPath
		this.zone := zone
	}

	search() {
		add_img_search(new ImgSearch(this.name, text_concat(A_ScriptDir, this.imgPath), this.zone))
	}
}