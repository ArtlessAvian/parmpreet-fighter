extends "GroundState.gd"

var entering_number

func _run(subject, controller):
	if (controller.dir() >= 7):
		return "Jump"
	
	if (controller.dir() <= 3):
		return "Crouch"
	
	var try_attack = try_attack(subject, controller)
	if (try_attack != ""):
		return try_attack
	
	if (subject.get_node("Core/AnimationPlayer").current_animation == ""):
		if (controller.dir() == entering_number):
			# run?
			pass
		return self.grounded_check(subject, controller)
	
	subject.vel.x = (entering_number - 5) * 7;

func _enter(subject, controller, old_state, args):
	entering_number = subject.scale.x + 5;

func _is_static(): return true