extends "Reel.gd"

func _run(subject, controller):
	
	subject.vel.x = 2 * knockback / hitstun * (1 - frame_no * 1.0 / hitstun)
	subject.vel.x = max(0, subject.vel.x)
	
	subject.vel.x *= dir
	frame_no += 1
	
	if (subject.get_node("Core/AnimationPlayer").current_animation == ""):
		subject.emit_signal("im_dead", subject)
		get_tree().change_scene_to(load("res://fight/Fight.tscn"))

func _enter(subject, controller, old_state, args):
	hitter = args["hitter"]
	knockback = args["knockback"] * 3
	hitstun = args["hitstun"] * 3
	
#	TODO: SEE REEL.
#	AHHHHHHHHHHH
	dir = hitter.global_scale.y
	
	frame_no = 0