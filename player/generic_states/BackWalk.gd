extends "../PlayerState.gd"

var entering_number = 4

func run(controller):
	if (controller.dir() != entering_number):
		subject.grounded_check(controller)
		return
	subject.position.x -= subject.scale.x * 2;

func enter(enter):
	entering_number = enter;