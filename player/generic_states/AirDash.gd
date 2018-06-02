extends "../PlayerState.gd"

func run(controller):
	if (get_parent().get_node("AnimationPlayer").current_animation != ""):
		get_parent().subject.vel.y -= 0.5
	

func enter(enter):
	print("airdash")
	get_parent().subject.vel.y = 0
	get_parent().subject.vel.x = (enter - 5) * 7