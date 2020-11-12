extends "PlayerState.gd"

func _ready():
	attack_pool = "Standing"

func grounded_check(subject, controller):
#	reset_hitboxes()
	
	if (subject.scale.x * (subject.get_enemy().position.x - subject.position.x) < 0):
		subject.scale.x *= -1
	
	if (controller.dir() >= 7):
		for i in range(0,10):
			if (controller.buffer[i] <= 3):
				return "SuperJump"
		return "Jump"
	
	if (controller.dir() <= 3):
		return "Crouch"

	# Dash
	if (controller.detect_motion("656", subject.scale.x < 0, 10)):
		return "Dash"

	if (controller.dir() == 6 || controller.dir() == 4):
		if ((controller.dir() == 6) == (subject.scale.x == 1)):
			return "Walk"
		else:
			return "BackWalk"
			
	return "Stand"