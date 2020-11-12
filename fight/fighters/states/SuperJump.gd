extends "Jump.gd"

func _run(subject, controller):
	var res = ._run(subject, controller)
	
	if (res != null):
		return res

func _enter(subject, controller, old_state, args):
	entering_number = controller.dir()
	if (subject.grounded and entering_number >= 7):
		subject.vel.y = -14;
		subject.vel.x = (entering_number - 8) * 5;
	
	ready = false
	subject.grounded = false