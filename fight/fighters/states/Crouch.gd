extends "GroundState.gd"

func _run(subject, controller):
	if (subject.scale.x * (subject.enemy.position.x - subject.position.x) < 0):
		subject.scale.x *= -1
	
	if (controller.dir() > 3):
		return self.grounded_check(subject, controller)
	
	subject.vel.x = 0

func _is_static(): return true