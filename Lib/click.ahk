click(x, y) {
	click_left(x, y)
}

click_withOffset(pos, offset) {
	x := pos.x + offset.x
	y := pos.y + offset.y
	click_left(x,y)
}

click_left(x, y) {
	mouseMove(x, y)
	click_keep_left_pressed()
	click_release_left()
}

click_press_left(x, y) {
	mouseMove(x, y)
	click_keep_left_pressed()
}

click_keep_left_pressed() {
	Click, down, left
}

click_release_left() {
	Click, up, left
}

click_right(x, y) {
	mouseMove(x, y)
	Click, down, right
	Click, up, right
}