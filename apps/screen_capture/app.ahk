
#Include %A_ScriptDir%/apps/screen_capture/sequences/crop_img_with_gimp.ahk

global appScreenCaptureXPos
global appScreenCaptureYPos
global appScreenCaptureInputXPos
global appScreenCaptureInputYPos
global appScreenCaptureInput2XPos
global appScreenCaptureInput2YPos
global appScreenCaptureOffsetXPos
global appScreenCaptureOffsetYPos
global appScreenCapturePixelColor
global appScreenCaptureInfo
global appScreenCaptureMod
global AppScreenCaptureScreenName
global AppScreenCaptureScreenDescription

global appScreenCaptureHasSetClickListener := false
global appScreenCaptureHasSetSelectionMenu := false
global appScreenCaptureHasRegisteredScreenName := false
global appScreenCaptureHasLaunchedSaveImg := false
global appScreenCaptureHasLaunchedGimp := false

appScreenCapture() {
	setAppScreenCaptureSelectionMenu()
	if(appScreenCaptureMod == WINDOW_SEARCH_TYPE.PIXEL) {
		PixelMod()
	}
	if(appScreenCaptureMod == WINDOW_SEARCH_TYPE.IMG) {
		ImgMod()
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
	set_prompt_mod(prompt)
}

AppScreenCaptureSetPixelMod() {
	appScreenCaptureMod := WINDOW_SEARCH_TYPE.PIXEL
	end_prompt_mode()
}

AppScreenCaptureSetImgMod() {
	appScreenCaptureMod := WINDOW_SEARCH_TYPE.IMG
	end_prompt_mode()
}

appScreenCaptureEmptyHotkey() {
	; DO NOTHING
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
		appScreenCaptureInfo = %appScreenCaptureInfo%`n`To launch { x1, y1 } of the img zone, left click with mouse
	}
	if(!!appScreenCaptureInputXPos && !appScreenCaptureInput2XPos) {
		appScreenCaptureInfo = %appScreenCaptureInfo%`n`To launch { x2, y2 } of the img zone, left click with mouse
		appScreenCaptureInfo = %appScreenCaptureInfo%`n` { x1: %appScreenCaptureInputXPos%, y1: %appScreenCaptureInputYPos% }
	}
	if(!!appScreenCaptureInput2XPos) {
		appScreenCaptureInfo = %appScreenCaptureInfo%`n` { x1: %appScreenCaptureInputXPos%
			, y1: %appScreenCaptureInputYPos%
			, x2: %appScreenCaptureInput2XPos%
			, y2: %appScreenCaptureInput2YPos% }
		appScreenCaptureInfo = %appScreenCaptureInfo%`n`Press enter to register the zone or left click to start again
	}
}

registerImgZone() {
	if(!appScreenCaptureInputXPos) {
		appScreenCaptureInputXPos := appScreenCaptureXPos
		appScreenCaptureInputYPos := appScreenCaptureYPos
		return
	}
	if(!appScreenCaptureInput2XPos) {
		Send !{PrintScreen}
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

	if(!appScreenCaptureHasLaunchedGimp) {
		gimp.start()
		appScreenCaptureHasLaunchedGimp := true
	}
	gimp.activate()
	gimpPlugin.activate()
	sequenceCropImgWithGimp(AppScreenCaptureScreenName, { x1: appScreenCaptureInputXPos, y1: appScreenCaptureInputYPos, x2: appScreenCaptureInput2XPos, y2: appScreenCaptureInput2YPos })
}

saveImgZone() {
	if(appScreenCaptureHasRegisteredScreenName ||!appScreenCaptureInputXPos || !appScreenCaptureInput2XPos) {
		return
	}
	Hotkey, LButton, off
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
	prompt.addButton("AppScreenCaptureRegisterImgScreenName", "Register Screen")
	set_prompt_mod(prompt)
}

setImgModClickInputListener() {
	if(appScreenCaptureHasSetClickListener) {
		return
	}
	appScreenCaptureHasSetClickListener := true
	Hotkey, LButton, registerImgZone
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
	windowSearch := new WindowSearch(WINDOW_SEARCH_TYPE.IMG
		, AppScreenCaptureScreenName
		, { x1: appScreenCaptureInputXPos, y1: appScreenCaptureInputYPos, x2: appScreenCaptureInput2XPos, y2: appScreenCaptureInput2YPos }
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
	MouseGetPos, appScreenCaptureXPos, appScreenCaptureYPos
	PixelGetColor, appScreenCapturePixelColor, appScreenCaptureXPos, appScreenCaptureYPos
	appScreenCaptureInfo = x%appScreenCaptureXPos% y%appScreenCaptureYPos%`n` %appScreenCapturePixelColor%
	appScreenCaptureInfo = %appScreenCaptureInfo%`n`Left click with mouse to register color & position
}

setpixelModClickInputListener() {
	if(appScreenCaptureHasSetClickListener) {
		return
	}
	appScreenCaptureHasSetClickListener := true
	Hotkey, LButton, appScreenCaptureSetRegisterPixelScreenName
	Hotkey, Enter, appScreenCaptureEmptyHotkey
}

AppScreenCaptureRegisterPixelScreenName() {
	submit_prompt()
	dir = %A_ScriptDir%\screens\
	fileName = %AppScreenCaptureScreenName%.ahk 
	path = %dir%%fileName%
	import_path = %dir%import.ahk
	date := date_get()
	time := time_clock_logformat()
	pixelColor = %appScreenCapturePixelColor%

	windowSearch := new WindowSearch(WINDOW_SEARCH_TYPE.PIXEL
		, AppScreenCaptureScreenName
		, false
		, { x: appScreenCaptureXPos, y: appScreenCaptureYPos }
		, false
		, pixelColor)
	windowSearchGlobalVar := windowSearch.buildFromData()
	if(appScreenCapturePixelColor) {
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
	Reload
}

appScreenCaptureSetRegisterPixelScreenName() {
	if(appScreenCaptureHasRegisteredScreenName) {
		return
	}
	Hotkey, LButton, off
	Hotkey, Enter, off
	appScreenCaptureHasRegisteredScreenName := true
	ToolTip % null
	screenInfo = Info registered for screen`n`
	screenInfo = Type : SINGLE PIXEL WITH POSITION`n`
	if(appScreenCaptureXPos) {
		screenInfo = %screenInfo% `n` Pixel position : { x: %appScreenCaptureXPos%, y: %appScreenCaptureYPos% }
	}
	if(appScreenCapturePixelColor) {
		screenInfo = %screenInfo% `n` Pixel color : %appScreenCapturePixelColor%
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