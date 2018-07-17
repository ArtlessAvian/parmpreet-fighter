extends "AirState.gd"

func _run(subject, controller):
#	if (get_parent().get_node("AnimationPlayer").current_animation == ""):
#		if (controller.dir() != 5):
	return self.air_action(subject, controller)
#	else:
	subject.vel.y -= 0.5
	

func _enter(subject, old_state):
	pass
#	print("airdash")
#	subject.vel.y = 0
#	subject.vel.x = ( - 5) * 7