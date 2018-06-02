extends "../PlayerState.gd"

var entering_number = 8

func run(controller):
	if (controller.detect_motion("454", 10) || controller.detect_motion("656", 10)):
		get_parent().change_state("AirDash", controller.dir())
		return

func enter(enter):
	entering_number = enter;
	
	var subject = get_parent().subject
	subject.vel.y = -10;
	subject.vel.x = (entering_number - 8) * 7;
	subject.grounded = false