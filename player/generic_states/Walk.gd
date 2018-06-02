extends "../PlayerState.gd"

var entering_number = 6

func run(controller):
#	if (controller.dir() <= 3):
#		get_parent().change_state("Crouch")
	if (controller.dir() != entering_number):
		subject.grounded_check(controller)
		return
	subject.position.x += subject.scale.x * 3;

func enter(enter):
	entering_number = enter;