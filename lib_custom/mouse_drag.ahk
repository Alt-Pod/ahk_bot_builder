global hasMouseDragStarted := false
global mouseDragCount := 0

handle_mouse_drag() {
	drag := CYCLE_DATA.mouseDrag
	if(drag == false || CYCLE_DATA.hasEngineWorked) {
		return
	}
	verify_mouse_drag(drag)
	CYCLE_DATA.hasEngineWorked := true
	start := drag.start
	end := drag.end
	if(mouseDragCount == 0) {
		mouseMove(start.x, start.y)
		click_keep_left_pressed()
	}
	diffX := start.x - end.x
	diffX := math_absolute(diffX)
	diffY := start.y - end.y
	diffY := math_absolute(diffY)
	max := diffX
	if(diffX < diffY) {
		max := diffY
	}
	ratioDrag := mouseDragCount/max
	clickX := start.x + ratioDrag*diffX
	clickY := start.y + ratioDrag*diffY
	mouseMove(clickX, clickY)
	if(mouseDragCount == max) {
		delete_mouse_drag()
		return
	}
	mouseDragCount := mouseDragCount + 1
}

mouse_drag(start, end) {
	set_mouse_drag(start, end)
}

get_mouse_drag() {
	return CYCLE_DATA.mouseDrag
}
set_mouse_drag(start, end) {
	CYCLE_DATA.mouseDrag := { start: start, end: end }
}
delete_mouse_drag() {
	click_release_left()
	mouseDragCount := 0
	hasMouseDragStarted := false
	CYCLE_DATA.mouseDrag := false
}

verify_mouse_drag(drag) {
	if(!drag.start.x || !drag.start.y || !drag.end.x || !drag.end.y) {
		MsgBox, you passed unusual parameters to mouse_drag()
	}
}