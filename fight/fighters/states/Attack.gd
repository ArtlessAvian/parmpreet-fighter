extends "res://StateMachine.gd".State

func _run(subject, controller):
	if (subject.get_node("Core/AnimationPlayer").current_animation == ""):
		return "Stand"