extends "../PlayerState.gd"

var entering_number

func run(controller):
	if (controller.dir() >= 7):
		get_parent().change_state("Jump", controller.dir())
		return
	
	var subject = get_parent().subject
	
	if (get_parent().get_node("AnimationPlayer").current_animation == ""):
		if (controller.dir() == entering_number):
			# run?
			pass
		subject.grounded_check(controller)
		return
	
	subject.vel.x = (entering_number - 5) * 7;

func enter(enter):
	print(enter)
	entering_number = enter;