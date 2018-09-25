extends "PlayerState.gd"

export (float, 0, 10) var damage = 1
export (float) var knockback = 40
export (float) var hitstun = 20
export (bool) var low = false
export (bool) var high = false

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
			if (controller.dir() > 3):
				return "Stand"
			else:
				return "Crouch"
		else:
			return "Jump"

func _enter(subject, controller, old_state, args):
#	if (old_state.attack_pool == "Standing"):
	if (subject.grounded):
		subject.vel.x = 0
	
	subject.get_node("Core").damage = damage
	subject.get_node("Core").knockback = knockback
	subject.get_node("Core").hitstun = hitstun
	subject.get_node("Core").low = low
	subject.get_node("Core").high = high

func _exit(subject, controller, state_str):
	subject.get_node("Core").have_hit = false;