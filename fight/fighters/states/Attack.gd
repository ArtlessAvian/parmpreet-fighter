extends "PlayerState.gd"

export (float, 0, 10) var damage = 1
export (float) var knockback = 40
export (float) var vert_knockback = 0
export (float) var hitstun = 20
export (bool) var low = false
export (bool) var high = false
export (bool) var jump_cancelable = false;

export (int) var sound_primary = 0

func _ready():
	can_block = false

func _run(subject, controller):
	
	if (subject.get_node("Core").have_hit):
		alter_pool(subject, controller)
		var try_attack = try_attack(subject, controller)
		if (try_attack != ""):
			return try_attack
		
		if (controller.dir() > 6 and jump_cancelable):
			if (subject.grounded):
				return "Jump"
			elif (subject.air_action > 0):
				subject.air_action -= 1
				return "DoubleJump"
	
	if (subject.get_node("Core/AnimationPlayer").current_animation == ""):
		if (subject.grounded):
			if (controller.dir() > 3):
				return "Stand"
			else:
				return "Crouch"
		else:
			return "Jump"

func alter_pool(subject, controller):
	if (subject.grounded):
		if (controller.dir() > 3):
			attack_pool = "Standing"
		else:
			attack_pool = "Crouching"
	else:
		attack_pool = "Jumping"

func _enter(subject, controller, old_state, args):
#	if (old_state.attack_pool == "Standing"):
	if (subject.grounded):
		subject.vel.x = 0
	
	var core = subject.get_node("Core")
	
	core.damage = damage
	core.knockback = knockback
	core.vert_knockback = vert_knockback
	core.hitstun = hitstun
	core.low = low
	core.high = high
	
	subject.get_node("Core/AudioStreamPlayer2D").stream = subject.sound_bank[sound_primary]
#	subject.get_node("Core/AudioStreamPlayer2D").play()

func _exit(subject, controller, state_str):
	subject.get_node("Core").have_hit = false;