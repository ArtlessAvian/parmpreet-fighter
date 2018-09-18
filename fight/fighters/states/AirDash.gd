extends "AirState.gd"


func _run(subject, controller):
	var try_attack = try_attack(subject, controller)
	if (try_attack != ""):
		return try_attack
	
	if (subject.get_node("Core/AnimationPlayer").current_animation == ""):
#		subject.vel.x = 0
		if (controller.dir() != 5):
			return self.air_action(subject, controller)
	
	else:
		subject.vel.y -= 0.5

func _enter(subject, controller, old_state, args):
	subject.vel.y = 0
	subject.vel.x = (controller.dir() - 5) * 7