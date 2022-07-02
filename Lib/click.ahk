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
	Click, down, left
	Click, up, left
}

click_press_left(x, y) {
	mouseMove(x, y)
	Click, down, left
}

click_release_left() {
	Click, down, left
}

click_right(x, y) {
	mouseMove(x, y)
	Click, down, right
	Click, up, right
}