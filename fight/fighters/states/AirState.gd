extends "PlayerState.gd"

func _ready():
	attack_pool = "Jumping"
	
func air_action(subject, controller):
	if (subject.air_action <= 0):
		return
	
	if (controller.dir() >= 7):
		subject.air_action -= 1
		return "DoubleJump"
	
	if (controller.detect_motion("454", false, 10) || controller.detect_motion("656", false, 10) ||
	  controller.detect_motion("754", false, 10) || controller.detect_motion("956", false, 10)):
		subject.air_action -= 1
		return "AirDash"