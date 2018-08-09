extends "AirState.gd"

func _run(subject, controller):
	if (subject.get_node("Core/AnimationPlayer").current_animation == ""):
		if (controller.dir() != 5):
			return self.air_action(subject, controller)
	
	else:
		subject.vel.y -= 0.5

func _enter(subject, controller, old_state, args):
	print("airdash")
	subject.vel.y = 0
	subject.vel.x = (controller.dir() - 5) * 7