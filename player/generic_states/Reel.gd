extends "../PlayerState.gd"

func run(controller):
	if (get_parent().subject.hitstun == 0):
		get_parent().subject.grounded_check(controller)

#func enter(enter):

func animation_name(controller):
	return "Reel"