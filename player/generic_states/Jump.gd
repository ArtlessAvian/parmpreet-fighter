extends "../PlayerState.gd"

var entering_number = 8

func enter(enter):
	entering_number = enter;
	
	var subject = get_parent().subject
	subject.vel.y = -10;
	subject.vel.x = (entering_number - 8) * 5;
	subject.grounded = false