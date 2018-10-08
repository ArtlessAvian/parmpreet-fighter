extends "PlayerState.gd"

var frame_no = 0
var dir = 1
var knockback = 100
var vert_knockback = 0
var hitstun = 100
var hitter = null

func _ready():
	can_block = false

func _run(subject, controller):
	subject.vel.x = max(0, 2 * knockback / hitstun * (1 - frame_no * 1.0 / hitstun))
	subject.vel.x *= dir
	frame_no += 1
	
	if (frame_no >= hitstun):
		subject.enemy_combo = 0
		subject.emit_signal("combo_escape")
		return "Stand"

func _enter(subject, controller, old_state, args):
	hitter = args["hitter"]
	knockback = args["knockback"]
	vert_knockback = args["vert_knockback"]
	hitstun = args["hitstun"]
	
#	TODO: It appears that X is Y? i am confuse
# 	SUPER CONFUSE.
#	NO REALLY WHY
	dir = hitter.global_scale.y
	
	# Assumes default gravity of 0.5
	subject.vel.y = -sqrt(vert_knockback)
	
	
	if (vert_knockback > 0):
		subject.grounded = false
	
	frame_no = 0

func on_land(subject, controller):
	return ""