extends "../PlayerState.gd"

var entering_number = 8
var ready = false

func run(controller):
	
	if (controller.dir() == 5):
		ready = true
	
	if (ready && controller.dir() != 5):
		get_parent().subject.air_action(controller)

func enter(enter):
	entering_number = enter;
	ready = false
	
	var subject = get_parent().subject
	if (entering_number >= 7):
		subject.vel.y = -10;
		subject.vel.x = (entering_number - 8) * 7;
	subject.grounded = false

func animation_name(controller):
	if (entering_number != 0):
		return "Jump"
	else:
		return ""