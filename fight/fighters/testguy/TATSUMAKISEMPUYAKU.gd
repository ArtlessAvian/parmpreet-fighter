extends "../states/Attack.gd"

var frame_no = 0

func _run(subject, controller):
	subject.vel.y = 0
	
	if (frame_no >= 6 and frame_no <= 40):
		subject.vel.x = min(7, (frame_no - 40) * -0.5) * subject.scale.x
	
	if (subject.get_node("Core/AnimationPlayer").current_animation == ""):
		if (subject.grounded):
			if (controller.dir() > 3):
				return "Stand"
			else:
				return "Crouch"
		else:
			return "Jump"
	
	frame_no += 1

func _enter(subject, controller, old_state, args):
	subject.vel.x = 0
	
	subject.get_node("Core").damage = damage
	subject.get_node("Core").knockback = knockback
	subject.get_node("Core").hitstun = hitstun
	subject.get_node("Core").low = low
	subject.get_node("Core").high = high
	
	frame_no = 0

func _exit(subject, controller, state_str):
	subject.get_node("Core").have_hit = false;