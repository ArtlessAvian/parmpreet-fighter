extends "GroundState.gd"

var entering_number = -1

func _run(subject, controller):
	if (controller.dir() != entering_number):
		return self.grounded_check(subject, controller)
	
	if ((entering_number - 5) * (subject.scale.x) < 0):
		subject.scale.x *= -1
		return "BackWalk"
	
	var try_attack = try_attack(subject, controller)
	if (try_attack != ""):
		return try_attack
	
	if (subject.scale.x * (subject.enemy.position.x - subject.position.x) < 0):
		subject.scale.x *= -1
	
	subject.vel.x = (entering_number - 5) * 5;

func _enter(subject, controller, old_state, args):
	entering_number = 5 + subject.scale.x;

func _is_static(): return true