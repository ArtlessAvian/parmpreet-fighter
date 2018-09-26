extends "Jump.gd"

func _enter(subject, controller, old_state, args):
	entering_number = controller.dir()
	if (entering_number >= 7):
		subject.vel.y = -10;
		subject.vel.x = (entering_number - 8) * 4;
	
	ready = false

func animation_name():
	return "Jump"