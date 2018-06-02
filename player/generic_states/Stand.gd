extends "../PlayerState.gd"

func run(controller):
	if (controller.dir() != 5):
		subject.grounded_check(controller)
		return
	
#	Turn around if you need to