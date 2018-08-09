extends "GroundState.gd"

var entering_number

func _run(subject, controller):
	if (controller.dir() >= 7):
		return "Jump"
	
	if (get_parent().get_node("AnimationPlayer").current_animation == ""):
		if (controller.dir() == entering_number):
			# run?
			pass
		return subject.grounded_check(controller)
	
	subject.vel.x = (entering_number - 5) * 7;

func _enter(subject, old_state, args):
	entering_number = args;

func _is_static(): return true