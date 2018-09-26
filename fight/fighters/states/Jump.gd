extends "AirState.gd"

var entering_number = -1
var ready = false

func _run(subject, controller):
	
	var try_attack = try_attack(subject, controller)
	if (try_attack != ""):
		return try_attack
	
	if (controller.dir() == 5):
		ready = true
	
	if (ready && controller.dir() != 5):
		return self.air_action(subject, controller)

func _enter(subject, controller, old_state, args):
	entering_number = controller.dir()
	if (subject.grounded and entering_number >= 7):
		subject.vel.y = -10;
		subject.vel.x = (entering_number - 8) * 4;
	
	ready = false
	subject.grounded = false