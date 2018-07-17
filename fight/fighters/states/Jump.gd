extends "AirState.gd"

var entering_number = -1
var ready = false

func _run(subject, controller):
	
	if (entering_number == -1):
		entering_number = controller.dir()
		if (entering_number >= 7):
			subject.vel.y = -10;
			subject.vel.x = (entering_number - 8) * 7;
	
	if (controller.dir() == 5):
		ready = true
	
	if (ready && controller.dir() != 5):
		return self.air_action(subject, controller)

func _enter(subject, old_state):
	entering_number = -1;
	ready = false
	subject.grounded = false