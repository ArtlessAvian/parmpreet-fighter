extends "res://StateMachine.gd".State

func grounded_check(subject, controller):
#	reset_hitboxes()
	
	if (subject.scale.x * (subject.enemy.position.x - subject.position.x) < 0):
		subject.scale.x *= -1
	
	if (controller.dir() >= 7):
		return "Jump"
	
	# Supers
	
	# Special Attacks
	
	# Attacks
	
	if (controller.dir() <= 3):
		return "Crouch"

	# Dash
#	if (subject.scale.x == 1 && controller.detect_motion("656", 10)):
#		return "Dash"
#	if (subject.scale.x == -1 && controller.detect_motion("454", 10)):
#		return "Dash"

	if (controller.dir() == 6 || controller.dir() == 4):
		if ((controller.dir() == 6) == (subject.scale.x == 1)):
			return "Walk"
		else:
			return "BackWalk"
			
	return "Stand"