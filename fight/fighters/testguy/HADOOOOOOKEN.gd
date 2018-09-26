extends "../states/Attack.gd"

var frame_no = 0
var projectile = preload("res://fight/fighters/testguy/HADOOOOOOKEN Core.tscn")

func _run(subject, controller):
	
	if (frame_no == 16):
		var instance = projectile.instance()
		get_tree().current_scene.add_child(instance)
		instance.global_position = subject.position
		instance.position.y += -40
		instance.position.x += subject.scale.x * 40
		instance.scale.x = subject.scale.x
		instance.get_node("Hitboxes").collision_layer = subject.get_node("Core/Hitboxes").collision_layer
	
	if (subject.get_node("Core/AnimationPlayer").current_animation == ""):
		if (subject.grounded):
			if (controller.dir() > 3):
				return "Stand"
			else:
				return "Crouch"
		else:
			return "Jump"
	
	frame_no += 1

func _enter(subject, controller, old_state, args):
	if (subject.grounded):
		subject.vel.x = 0
	frame_no = 0

func _exit(subject, controller, state_str):
	subject.get_node("Core").have_hit = false;