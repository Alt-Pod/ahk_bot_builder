game_log(game) {
	toLog := ""
	if(!game.hasStarted) {
		toLog = %toLog% `n The game hasn't started yet`
	} else {
		time := time_diff(game.startTime,time_get())
		timeFormatted := time_format(time)
		toLog = %toLog% `n %timeFormatted%`
		if(time_sec(time) < 2) {
			toLog = %toLog% `n The game just started`
		}
		if(time_sec(time) > 2 && time_sec(time) < 10) {
			team := game.team
			champion := game.champion
			toLog = %toLog% `n Your team is %team% and you play %champion%`
		}
		if(time_sec(time) > 10) {
			if(game.shopIsOpen) {
				toLog = %toLog% `n Currently shopping...`
			}
			if(game.inventory.length() > 0) {
				toLog = %toLog% `n Inventory :`
				Loop % game.inventory.length() {
					item := game.inventory[A_Index]
					toLog = %toLog% `n     %item%`
				}
			}
			if(game.isAllyAlive) {
				allyLife := game.allyLife
				toLog = %toLog% `n ally life : %allyLife%`%
			} else {
				toLog = %toLog% `n ally is dead`
			}
			champion := game.champion
			if(game.atFountain) {
				toLog = %toLog% `n %champion% is at fountain`
			} else {
				toLog = %toLog% `n %champion% is not at fountain`
			}
			if(game.isDead) {
				toLog = %toLog% `n %champion% is dead`
			} else {
				health := game.health
				toLog = %toLog% `n %champion% has %health%`% health
			}
		}
		mode := game.mode
		stacks := eventHandler.eventStack.stack.length()
		toLog = %toLog% `n ___________________`
		toLog = %toLog% `n stacks : %stacks%`
		toLog = %toLog% `n mode : %mode%`
	}
	
	ToolTip % toLog
}