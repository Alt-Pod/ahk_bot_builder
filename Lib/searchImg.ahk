searchImg(path, zone = "") {
	if(!zone) {
		zone := { x1: 0, y1: 0, x2: A_ScreenWidth, y2: A_ScreenHeight }
	}
	result := { name: "", path: path, found: false, x: 0, y: 0 }
	if(path) {
		ImageSearch, pos_x, pos_y, zone.x1, zone.y1, zone.x2, zone.y2, *5 %path%
	    if(pos_x) {
        	result.name := searchImg_formatImgName(path)
	    	result.found := true
	    	result.x := pos_x
	    	result.y := pos_y
	    }
	}
	return result
}

searchImg_byFileIndex(path, index) {
	folder = %A_ScriptDir%%path%
	ImagePath := ""
	Loop, %folder%*.png {
        currentIndex := StrSplit(A_LoopFileName, "_")[1]
        if(currentIndex == index) {
        	ImagePath = %folder%%A_LoopFileName%
        	break
        }
    }
	searchImgResult := searchImg(ImagePath, searchImg_getImgZoneFromPath(ImagePath))
	return searchImgResult
}

searchImg_getImgZoneFromPath(path) {
	zone := ""
	splitPath := StrSplit(path, "\")
	imageName := StrSplit(splitPath[splitPath.length()], ".")[1]
	if(string_contains(imageName,"coord")) {
		splitImageName :=  StrSplit(imageName, "-")
		zone := { x1: splitImageName[2], y1: splitImageName[3], x2: splitImageName[4], y2: splitImageName[5] }
	}
	return zone
}

searchImg_formatImgName(path) {
	splitPath := StrSplit(path, "\")
	filename := StrSplit(splitPath[splitPath.length()], ".")[1]
	arrayFilename := StrSplit(filename, "_")
	if(string_isANumber(arrayFilename[1])) {
		toBeTrimmed := arrayFilename[1]
		toBeTrimmed = %toBeTrimmed%_
		filename := StrReplace(filename, toBeTrimmed, "")
	}
	if(string_contains(arrayFilename[arrayFilename.length()], "coord")) {
		toBeTrimmed := arrayFilename[arrayFilename.length()]
		toBeTrimmed = _%toBeTrimmed%
		filename := StrReplace(filename, toBeTrimmed, "")
	}
	return filename
}

searchImg_getNumberOfImgInFolder(path) {
	sum := 0
	Loop, %A_ScriptDir%%path%*.png {
		sum := sum + 1
	}
	return sum
}