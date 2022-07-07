global WINDOW_SEARCH_TYPE := { PIXEL: "PIXEL"
	, IMG: "IMG" }

CYCLE_DATA.uiScan := new UIScan()

handle_ui_scan() {
	uiScan := CYCLE_DATA.uiScan
	if(uiScan.isEmpty() || CYCLE_DATA.hasEngineWorked) {
		return
	}
	CYCLE_DATA.hasEngineWorked := true
	if(uiScan.isRunning) {
		uiScan.run()
	} else {		
		uiScan.start()
	}
	CYCLE_DATA.uiScan := uiScan
}

add_window_search_to_ui_scan(windowSearch, success, failure, options = false) {
	uiScan := CYCLE_DATA.uiScan
	windowSearch.setCallbacks(success, failure, options)
	uiScan.addWindowSearch(windowSearch)
	CYCLE_DATA.uiScan := uiScan
}

class UIScan {
	__New() {
		this.windowSearchCollection := []
	}

	empty() {
		this.windowSearchCollection := []
	}

	isEmpty() {
		return this.windowSearchCollection.length() == 0
	}

	addWindowSearch(windowSearch) {
		this.windowSearchCollection := array_pushFirst(this.windowSearchCollection, windowSearch)
	}

	start() {
		this.isRunning := true
	}

	run() {
		currentWindowSearch := array_last(this.windowSearchCollection)
		this.windowSearchCollection := array_removeLast(this.windowSearchCollection)
		currentWindowSearch.run()
		if(this.windowSearchCollection.length() == 0) {
			this.isRunning := false
		}
	}
}

class WindowSearch {
	__New(type, name, zone = false, pixelPosition = false, imgName = false, pixelColor = false) {
		this.type := type
		this.name := name
		this.imgName := imgName
		this.pixelPosition := pixelPosition
		this.pixelColor := pixelColor
		if(type == WINDOW_SEARCH_TYPE.PIXEL) {
			this.zone := { x1: pixelPosition.x, y1: pixelPosition.y, x2: pixelPosition.x+1, y2: pixelPosition.y+1 }
		} else if(zone == false) {
			this.zone := { x1: 0, y1: 0, x2: A_ScreenWidth, y2: A_ScreenHeight }
		} else {
			this.zone := zone
		}
	}

	run() {
		log.add(text_concat("UIScan - WindowSearch name : ", this.name, ", type: ", this.type))
		if(this.type == WINDOW_SEARCH_TYPE.PIXEL) {
			this.handlePixelSearch()
		}
		if(this.type == WINDOW_SEARCH_TYPE.IMG) {
			this.handleImgSearch()
		}
	}

	setCallbacks(success, failure, options) {
		this.onSuccess := success
		this.onFailure := failure
		this.options := options
	}

	success(result) {
 		log.add(text_concat("UIScan - WindowSearch SUCCESS (found) - name : ", this.name, ", type: ", this.type))
		onSuccess := this.onSuccess
		if(!!onSuccess) {
			%onSuccess%(this.options, result)
		}
	}

	failure() {
		log.add(text_concat("UIScan - WindowSearch FAILURE (not found) - name : ", this.name, ", type: ", this.type))
		onFailure := this.onFailure
		if(!!onFailure) {
			%onFailure%(this.options)
		}
	}

	handleImgSearch() {
		imgName := this.imgName
		zone := this.zone
		imgPath = %A_ScriptDir%/screens/img/%imgName%.png
		ImageSearch, posX, posY, zone.x1, zone.y1, zone.x2, zone.y2, *5 %imgPath%
		if(posX) {
			this.success({ x: posX, y: posY})
			return
		}
		this.failure()
	}

	handlePixelSearch() {
		zone := this.zone
		PixelSearch, OutputVarX, OutputVarY, zone.x1, zone.y1, zone.x2, zone.y2, this.pixelColor, 3, Fast
		if(OutputVarX) {
			this.success({ x: OutputVarX, y: OutputVarY })
			return
		}
		this.failure()
	}

	buildFromData() {
		quote = `"`
		lineBreak := "`n        , "


		ahkObjectExport := "global screen_"
		ahkObjectExport := text_concat(ahkObjectExport, this.name," := new WindowSearch(")
		ahkObjectExport := text_concat(ahkObjectExport,quote,this.type,quote,lineBreak,quote,this.name,quote,lineBreak)
		if(this.type == WINDOW_SEARCH_TYPE.PIXEL) {
			ahkObjectExport := text_concat(ahkObjectExport,"false",lineBreak)
			ahkObjectExport := text_concat(ahkObjectExport
				, "{ x: ", this.pixelPosition.x, ", y: ", this.pixelPosition.y," }",lineBreak)
		}
		if(this.type == WINDOW_SEARCH_TYPE.IMG) {
			ahkObjectExport := text_concat(ahkObjectExport
				, "{ x1: ", this.zone.x1, ", y1: ", this.zone.y1, ", x2: ",this.zone.x2, ", y2: ", this.zone.y2, " }",lineBreak)
			ahkObjectExport := text_concat(ahkObjectExport,"false",lineBreak)
		}
		if(this.type == WINDOW_SEARCH_TYPE.PIXEL) {
			ahkObjectExport := text_concat(ahkObjectExport,"false",lineBreak)
			ahkObjectExport := text_concat(ahkObjectExport,quote,this.pixelColor,quote,")")
		}
		if(this.type == WINDOW_SEARCH_TYPE.IMG) {
			ahkObjectExport := text_concat(ahkObjectExport,quote,this.imgName,quote,lineBreak)
			ahkObjectExport := text_concat(ahkObjectExport,"false",")")
		}
		return ahkObjectExport
	}
}