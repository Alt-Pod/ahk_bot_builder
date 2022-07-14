
#Include %A_ScriptDir%/apps/sequences/crop_img_with_gimp.ahk

global appScreenCaptureXPos
global appScreenCaptureYPos
global appScreenCaptureInputXPos
global appScreenCaptureInputYPos
global appScreenCaptureInput2XPos
global appScreenCaptureInput2YPos
global appScreenCaptureOffsetXPos
global appScreenCaptureOffsetYPos
global appScreenCapturePixelColor
global appScreenCapturePixelColorInput
global appScreenCaptureInfo
global appScreenCaptureMod
global AppScreenCaptureScreenName
global AppScreenCaptureScreenDescription

global appScreenCaptureHasSetClickListener := false
global appScreenCaptureHasSetSelectionMenu := false
global appScreenCaptureHasRegisteredScreenName := false
global appScreenCaptureHasLaunchedSaveImg := false
global appScreenCaptureIsPixelCaptureComplete := false
global appScreenCaptureEndGimp := false
global appScreenCaptureNoZone := false

appScreenCapture() {
	setAppScreenCaptureSelectionMenu()
	if(appScreenCaptureMod == WINDOW_SEARCH_TYPE.PIXEL) {
		PixelMod()
	}
	if(appScreenCaptureMod == WINDOW_SEARCH_TYPE.IMG) {
		ImgMod()
	}
	if(appScreenCaptureMod == WINDOW_SEARCH_TYPE.IMG) {
		OcrMod()
	}
	if(!appScreenCaptureHasRegisteredScreenName && appScreenCaptureMod) {
		ToolTip % appScreenCaptureInfo
	}
}

setAppScreenCaptureSelectionMenu() {
	if(appScreenCaptureHasSetSelectionMenu) {
		return
	}
	appScreenCaptureHasSetSelectionMenu := true
	prompt := new PromptUI("Choose your Screen Capture mod", A_ScreenWidth/2, A_ScreenHeight/2)
	prompt.addButton("AppScreenCaptureSetPixelMod", "LAUNCH PIXEL MOD")
	prompt.addButton("AppScreenCaptureSetImgMod", "LAUNCH IMG MOD")
	prompt.addButton("AppScreenCaptureSetOcrMod", "LAUNCH OCR MOD")
	set_prompt_mod(prompt)
}

AppScreenCaptureSetOcrMod() {
	appScreenCaptureMod := WINDOW_SEARCH_TYPE.OCR
	end_prompt_mode()
}

AppScreenCaptureSetPixelMod() {
	appScreenCaptureMod := WINDOW_SEARCH_TYPE.PIXEL
	end_prompt_mode()
}

AppScreenCaptureSetImgMod() {
	appScreenCaptureMod := WINDOW_SEARCH_TYPE.IMG
	end_prompt_mode()
}

; MODS BELOW
; _______________________________________
; _______________________________________


; IMG MOD
; _______________________________________

ImgMod() {
	if(appScreenCaptureHasLaunchedSaveImg) {
		screenshotImgZone()
		return
	}
	if(appScreenCaptureHasRegisteredScreenName) {
		return
	}
	setImgModClickInputListener()
	MouseGetPos, appScreenCaptureXPos, appScreenCaptureYPos
	appScreenCaptureInfo = x%appScreenCaptureXPos% y%appScreenCaptureYPos%`n`screen_x%appScreenCaptureOffsetXPos% screen_y%appScreenCaptureOffsetYPos%
	if(!appScreenCaptureInputXPos) {
		appScreenCaptureInfo = %appScreenCaptureInfo%`n`To launch { x1, y1 } of the img zone, press space
	}
	if(!!appScreenCaptureInputXPos && !appScreenCaptureInput2XPos) {
		appScreenCaptureInfo = %appScreenCaptureInfo%`n`To launch { x2, y2 } of the img zone, press space
		appScreenCaptureInfo = %appScreenCaptureInfo%`n` { x1: %appScreenCaptureInputXPos%, y1: %appScreenCaptureInputYPos% }
	}
	if(!!appScreenCaptureInput2XPos) {
		appScreenCaptureInfo = %appScreenCaptureInfo%`n` { x1: %appScreenCaptureInputXPos%
			, y1: %appScreenCaptureInputYPos%
			, x2: %appScreenCaptureInput2XPos%
			, y2: %appScreenCaptureInput2YPos% }
		appScreenCaptureInfo = %appScreenCaptureInfo%`n` Press enter to register the zone or press space to start again
	}
}

registerImgZone() {
	if(!appScreenCaptureInputXPos) {
		appScreenCaptureInputXPos := appScreenCaptureXPos
		appScreenCaptureInputYPos := appScreenCaptureYPos
		return
	}
	if(!appScreenCaptureInput2XPos) {
		appScreenCaptureInput2XPos := appScreenCaptureXPos
		appScreenCaptureInput2YPos := appScreenCaptureYPos
		return
	}
	appScreenCaptureInputXPos := null
	appScreenCaptureInputYPos := null
	appScreenCaptureInput2XPos := null
	appScreenCaptureInput2YPos := null
}

screenshotImgZone() {
	gimpName = GNU Image Manipulation Program
	gimpNamePlugin = GNU Image Manipulation Program Plug-In
	gimpProcess = %A_ScriptDir%\utils\gimp\bin\gimp-2.8.exe
	gimp := new Program(gimpName, gimpProcess)
	gimpPlugin := new Program(gimpNamePlugin, gimpProcess)
	if(appScreenCaptureEndGimp) {
		gimp.end()
		reloadApp()
		return
	}
	gimp.start()
	gimp.activate()
	gimpPlugin.activate()
	zone := { x1: appScreenCaptureInputXPos, y1: appScreenCaptureInputYPos, x2: appScreenCaptureInput2XPos, y2: appScreenCaptureInput2YPos }
	sequenceCropImgWithGimp(AppScreenCaptureScreenName, zone, func("endSequenceCropImgWithGimp"))

}

endSequenceCropImgWithGimp() {
	appScreenCaptureEndGimp := true
}

saveImgZone() {
	if(appScreenCaptureHasRegisteredScreenName ||!appScreenCaptureInputXPos || !appScreenCaptureInput2XPos) {
		return
	}
	Send !{PrintScreen}
	Hotkey, Space, off
	Hotkey, Enter, off
	appScreenCaptureHasRegisteredScreenName := true
	ToolTip % null
	screenInfo = Info registered for screen :`n`
	screenInfo = Type : IMG WITH POSITION`n`n
	screenInfo = %screenInfo% { x1: %appScreenCaptureInputXPos%
		, y1: %appScreenCaptureInputYPos%
		, x2: %appScreenCaptureInput2XPos%
		, y2: %appScreenCaptureInput2YPos% }
	screenInfo = %screenInfo% `n` `n` Please enter a name for this screen : 
	prompt := new PromptUI("Give a name to your screen", A_ScreenWidth/2, A_ScreenHeight/2)
	prompt.addText(screenInfo)
	prompt.addInputText("AppScreenCaptureScreenName")
	prompt.addText("Screen description : ")
	prompt.addInputText("AppScreenCaptureScreenDescription")
	prompt.addCheckbox("appScreenCaptureNoZone", "Do not register the zone")
	prompt.addButton("AppScreenCaptureRegisterImgScreenName", "Register Screen")
	set_prompt_mod(prompt)
}

setImgModClickInputListener() {
	if(appScreenCaptureHasSetClickListener) {
		return
	}
	appScreenCaptureHasSetClickListener := true
	Hotkey, Space, registerImgZone
	Hotkey, Enter, saveImgZone
}

AppScreenCaptureRegisterImgScreenName() {
	submit_prompt()
	dir = %A_ScriptDir%\screens\
	fileName = %AppScreenCaptureScreenName%.ahk 
	path = %dir%%fileName%
	import_path = %dir%import.ahk
	date := date_get()
	time := time_clock_logformat()
	zone := { x1: appScreenCaptureInputXPos, y1: appScreenCaptureInputYPos, x2: appScreenCaptureInput2XPos, y2: appScreenCaptureInput2YPos }
	if(appScreenCaptureNoZone) {
		zone := false
	}
	windowSearch := new WindowSearch(WINDOW_SEARCH_TYPE.IMG
		, AppScreenCaptureScreenName
		, zone
		, false
		, AppScreenCaptureScreenName
		, false)
	windowSearchGlobalVar := windowSearch.buildFromData()
	if(appScreenCaptureInputXPos && appScreenCaptureInput2XPos) {
		FileAppend,
		(
			%windowSearchGlobalVar%

; Created at "%date% - %time%"
; Description : "%AppScreenCaptureScreenDescription%"
		), %path%
		FileAppend,
		(
			`n`#Include `%A_ScriptDir`%/screens/%fileName%
		), %import_path%
	}
	appScreenCaptureHasLaunchedSaveImg := true
}

; PIXEL MOD
; _______________________________________

pixelMod() {
	if(appScreenCaptureHasRegisteredScreenName) {
		return
	}
	setpixelModClickInputListener()
	setpixelModToolTip()
}

setpixelModToolTip() {
	MouseGetPos, appScreenCaptureXPos, appScreenCaptureYPos
	PixelGetColor, appScreenCapturePixelColor, appScreenCaptureXPos, appScreenCaptureYPos
	appScreenCaptureInfo = x%appScreenCaptureXPos% y%appScreenCaptureYPos%`n` %appScreenCapturePixelColor%
	if(appScreenCaptureInputXPos) {
		PixelGetColor, pixelColor, appScreenCaptureInputXPos, appScreenCaptureInputYPos
		appScreenCaptureInfo = %appScreenCaptureInfo%`n`Press space to start again `n`Press enter to save the pixel :
		appScreenCaptureInfo = %appScreenCaptureInfo%`n`{ x: %appScreenCaptureInputXPos%, y: %appScreenCaptureInputYPos%, color: %pixelColor% }
		return
	}
	appScreenCaptureInfo = %appScreenCaptureInfo%`n` Press space to register color & position
}

setpixelModClickInputListener() {
	if(appScreenCaptureHasSetClickListener) {
		return
	}
	appScreenCaptureHasSetClickListener := true
	Hotkey, Space, appScreenCaptureSetRegisterPixel
	Hotkey, Enter, appScreenCaptureSetRegisterPixelScreenName
}

AppScreenCaptureRegisterPixelScreenName() {
	submit_prompt()
	dir = %A_ScriptDir%\screens\
	fileName = %AppScreenCaptureScreenName%.ahk 
	path = %dir%%fileName%
	import_path = %dir%import.ahk
	date := date_get()
	time := time_clock_logformat()

	windowSearch := new WindowSearch(WINDOW_SEARCH_TYPE.PIXEL
		, AppScreenCaptureScreenName
		, false
		, { x: appScreenCaptureInputXPos, y: appScreenCaptureInputYPos }
		, false
		, appScreenCapturePixelColorInput)
	windowSearchGlobalVar := windowSearch.buildFromData()
	if(appScreenCapturePixelColorInput) {
		FileAppend,
		(
			%windowSearchGlobalVar%

; Created at "%date% - %time%"
; Description : "%AppScreenCaptureScreenDescription%"
		), %path%
		FileAppend,
		(
			`n`#Include `%A_ScriptDir`%/screens/%fileName%
		), %import_path%
	}
	success = Your screen %AppScreenCaptureScreenName% has been saved
	reloadApp()
}

appScreenCaptureSetRegisterPixel() {
	if(appScreenCaptureHasRegisteredScreenName) {
		return
	}
	if(appScreenCaptureInputXPos) {
		appScreenCaptureInputXPos := null
		appScreenCaptureInputYPos := null
		return
	}
	appScreenCaptureInputXPos := appScreenCaptureXPos
	appScreenCaptureInputYPos := appScreenCaptureYPos
}

appScreenCaptureSetRegisterPixelScreenName() {
	if(appScreenCaptureHasRegisteredScreenName) {
		return
	}
	PixelGetColor, appScreenCapturePixelColorInput, appScreenCaptureInputXPos, appScreenCaptureInputYPos
	Hotkey, Space, off
	Hotkey, Enter, off
	appScreenCaptureHasRegisteredScreenName := true
	ToolTip % null
	screenInfo = Info registered for screen`n`
	screenInfo = Type : SINGLE PIXEL WITH POSITION`n`
	if(appScreenCaptureInputXPos) {
		screenInfo = %screenInfo% `n` Pixel position : { x: %appScreenCaptureInputXPos%, y: %appScreenCaptureInputYPos% }
	}
	if(appScreenCapturePixelColorInput) {
		screenInfo = %screenInfo% `n` Pixel color : %appScreenCapturePixelColorInput%
	}
	screenInfo = %screenInfo% `n` `n` Please enter a name for this screen : 
	prompt := new PromptUI("Give a name to your screen", A_ScreenWidth/2, A_ScreenHeight/2)
	prompt.addText(screenInfo)
	prompt.addInputText("AppScreenCaptureScreenName")
	prompt.addText("Screen description : ")
	prompt.addInputText("AppScreenCaptureScreenDescription")
	prompt.addButton("AppScreenCaptureRegisterPixelScreenName", "Register Screen")
	set_prompt_mod(prompt)
}

; OCR MOD
; _______________________________________

OcrMod() {
	if(appScreenCaptureHasRegisteredScreenName) {
		return
	}
	setOcrModClickInputListener()
	MouseGetPos, appScreenCaptureXPos, appScreenCaptureYPos
	appScreenCaptureInfo = x%appScreenCaptureXPos% y%appScreenCaptureYPos%`n`screen_x%appScreenCaptureOffsetXPos% screen_y%appScreenCaptureOffsetYPos%
	if(!appScreenCaptureInputXPos) {
		appScreenCaptureInfo = %appScreenCaptureInfo%`n`To launch { x1, y1 } of the ocr zone, press space
	}
	if(!!appScreenCaptureInputXPos && !appScreenCaptureInput2XPos) {
		appScreenCaptureInfo = %appScreenCaptureInfo%`n`To launch { x2, y2 } of the ocr zone, press space
		appScreenCaptureInfo = %appScreenCaptureInfo%`n` { x1: %appScreenCaptureInputXPos%, y1: %appScreenCaptureInputYPos% }
	}
	if(!!appScreenCaptureInput2XPos) {
		appScreenCaptureInfo = %appScreenCaptureInfo%`n` { x1: %appScreenCaptureInputXPos%
			, y1: %appScreenCaptureInputYPos%
			, x2: %appScreenCaptureInput2XPos%
			, y2: %appScreenCaptureInput2YPos% }
		appScreenCaptureInfo = %appScreenCaptureInfo%`n` Press enter to register the zone or press space to start again
	}
}

setOcrModClickInputListener() {
	if(appScreenCaptureHasSetClickListener) {
		return
	}
	appScreenCaptureHasSetClickListener := true
	Hotkey, Space, appScreenCaptureSetRegisterOcrZone
	Hotkey, Enter, appScreenCaptureSetRegisterOcrZoneName
}

appScreenCaptureSetRegisterOcrZone() {
	if(!appScreenCaptureInputXPos) {
		appScreenCaptureInputXPos := appScreenCaptureXPos
		appScreenCaptureInputYPos := appScreenCaptureYPos
		return
	}
	if(!appScreenCaptureInput2XPos) {
		appScreenCaptureInput2XPos := appScreenCaptureXPos
		appScreenCaptureInput2YPos := appScreenCaptureYPos
		return
	}
	appScreenCaptureInputXPos := null
	appScreenCaptureInputYPos := null
	appScreenCaptureInput2XPos := null
	appScreenCaptureInput2YPos := null
}