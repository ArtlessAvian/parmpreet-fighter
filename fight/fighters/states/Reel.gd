extends "res://StateMachine.gd".State

var frame_no = 0;
var dir = 1;
var knockback = 100;
var hitstun = 100;
var hitter = null;

func _run(subject, controller):
	
	subject.vel.x = 2 * knockback / hitstun * (1 - frame_no * 1.0 / hitstun)
	
	subject.vel.x *= dir
	frame_no += 1
	
	if (frame_no >= hitstun):
		subject.enemy_combo = 0
		subject.emit_signal("combo_escape")
		return "Stand"

func _enter(subject, controller, old_state, args):
	hitter = args["hitter"]
	knockback = args["knockback"]
	hitstun = args["hitstun"]
	
	dir = hitter.get_parent().scale.x
	
	frame_no = 0