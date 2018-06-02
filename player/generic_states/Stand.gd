extends "../PlayerState.gd"

func run(controller):
	var subject = get_parent().subject;
	
	if (subject.scale.x * (subject.enemy.position.x - subject.position.x) < 0):
		subject.scale.x *= -1
	
	if (controller.dir() != 5):
		subject.grounded_check(controller)
		return
	
#	Turn around if you need to