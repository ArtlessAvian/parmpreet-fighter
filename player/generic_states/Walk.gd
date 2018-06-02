extends "../PlayerState.gd"

var entering_number = 6

func run(controller):
	var subject = get_parent().subject
	if (controller.dir() != entering_number):
		subject.grounded_check(controller)
		return
	
	if ((entering_number - 5) * (subject.scale.x) < 0):
		get_parent().change_state("BackWalk", controller.dir())
		return
	
	if (subject.scale.x * (subject.enemy.position.x - subject.position.x) < 0):
		subject.scale.x *= -1
	
	subject.position.x += (entering_number - 5) * 3;

func enter(enter):
	entering_number = enter;