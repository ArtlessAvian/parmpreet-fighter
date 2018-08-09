extends "GroundState.gd"

func _run(subject, controller):
	
	if (subject.scale.x * (subject.enemy.position.x - subject.position.x) < 0):
		subject.scale.x *= -1
	
	if (controller.dir() != 5):
		return self.grounded_check(subject, controller)
	
	if (Input.is_action_just_pressed(controller.focus + "_light")):
		return "Light"
#	if (controller.focus)
	
	subject.vel.x = 0
	
#	Turn around if you need to

func _is_static(): return true