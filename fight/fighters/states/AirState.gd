extends "res://StateMachine.gd".State

func air_action(subject, controller):
	if (subject.air_action <= 0):
		return
	
	if (controller.dir() >= 7):
		subject.air_action -= 1
		return "DoubleJump"
	
	if (controller.detect_motion("454", 10) || controller.detect_motion("656", 10) ||
	  controller.detect_motion("754", 10) || controller.detect_motion("956", 10)):
		subject.air_action -= 1
		return "AirDash"