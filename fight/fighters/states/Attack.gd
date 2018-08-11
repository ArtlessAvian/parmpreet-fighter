extends "PlayerState.gd"

func _run(subject, controller):
	
	if (subject.get_node("Core").have_hit):
		if (subject.grounded):
			if (controller.dir() > 3):
				attack_pool = "Standing"
			else:
				attack_pool = "Crouching"
		else:
			attack_pool = "Jumping"
		var try_attack = try_attack(subject, controller)
		if (try_attack != ""):
			return try_attack
	
	if (subject.get_node("Core/AnimationPlayer").current_animation == ""):
		if (subject.grounded):
			return "Stand"
		else:
			return "Jump"

func _enter(subject, controller, old_state, args):
#	if (old_state.attack_pool == "Standing"):
	if (subject.grounded):
		subject.vel.x = 0

func _exit(subject, controller, state_str):
	subject.get_node("Core").have_hit = false;