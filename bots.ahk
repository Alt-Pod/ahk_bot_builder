#Persistent
#NoEnv
SetBatchLines -1
ListLines Off
SendMode Input 

#Include %A_ScriptDir%\imports.ahk

main(){
	engine()
	if(!CYCLE_DATA.hasEngineWorked) {
		app()
	}
}

SetTimer, main, 1
f11::ExitApp