add_action(action) {
	CYCLE_DATA.action := action
}

handle_action() {
	action := CYCLE_DATA.action
	if(action == null || CYCLE_DATA.hasEngineWorked) {
		return
	}
	CYCLE_DATA.hasEngineWorked := true
	action.handle()
	CYCLE_DATA.action := null
}

global ACTION_TYPE := { CLICK_RIGHT: "CLICK_RIGHT"
	, CLICK_LEFT: "CLICK_LEFT"
	, CLICK_LEFT_OFFSET: "CLICK_LEFT_OFFSET"
	, CTRL_SHIFT_KEY: "CTRL_SHIFT_KEY" }

; AVAILABLE OPTIONS :
; x
; y
; offsetX
; offsetY
; key

class ScreenAction {
	__New(type, name = "undefined", options = false) {
		this.type := type
		this.name := name
		this.options := options
		this.setup()
	}

	handle() {
		log.add(text_concat("ACTION - name : ", this.name, ", type: ", this.type))
		if(this.type == ACTION_TYPE.CLICK_RIGHT) {
			click_right(this.options.x, this.options.y)
		}
		if(this.type == ACTION_TYPE.CLICK_LEFT) {
			click(this.options.x, this.options.y)
		}
		if(this.type == ACTION_TYPE.CLICK_LEFT_OFFSET) {
			click_withOffset({ x: this.options.x, y: this.options.y }, { x: this.options.offsetX, y: this.options.offsetY })
		}
		if(this.type == ACTION_TYPE.CTRL_SHIFT_KEY) {
			key := this.options.key
			Send ^+{%key%}
		}
	}

	setup() {
		if(!this.type) {
			log.add(text_concat("ACTION - Missing type for ", this.name), true)
		}
		if(this.type == ACTION_TYPE.CLICK_RIGHT && (!this.options || !this.options.x || !this.options.y)) {
			log.add(text_concat("ACTION - Missing options for ", this.name, ", type : " this.type), true)
		}
		if(this.type == ACTION_TYPE.CLICK_LEFT && (!this.options || !this.options.x || !this.options.y)) {
			log.add(text_concat("ACTION - Missing options for ", this.name, ", type : " this.type), true)
		}
		if(this.type == ACTION_TYPE.CTRL_SHIFT_KEY && (!this.options || !this.options.key)) {
			log.add(text_concat("ACTION - Missing options for ", this.name, ", type : " this.type), true)
		}
		if(this.type == ACTION_TYPE.CLICK_LEFT_OFFSET && (!this.options || !this.options.x || !this.options.y || !this.options.offsetX || !this.options.offsetY)) {
			log.add(text_concat("ACTION - Missing options for ", this.name, ", type : " this.type), true)
		}	
	}
}