extends "PlayerState.gd"

var frame_no = 0
var dir = 1

func _run(subject, controller):
	
	subject.vel.x = dir * max(0, 10 - 1 * frame_no)
	frame_no += 1
	
	if (subject.get_node("Core/AnimationPlayer").current_animation == ""):
		if (subject.grounded):
			if (controller.dir() > 3):
				return "Stand"
			else:
				return "Crouch"
		else:
			return "Jump"

var what_animation

func _enter(subject, controller, old_state, args):
	frame_no = 0
	dir = subject.enemy.scale.x
	subject.vel.y = 0
	what_animation = args

func animation_name():
	if (what_animation):
		return "BlockStunLow"
	else:
		return "BlockStun"