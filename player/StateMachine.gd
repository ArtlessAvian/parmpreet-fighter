extends Node

var subject = null
var current_state
var controller
var frame

func _ready():
#	$AnimationPlayer.playback_speed = 
#	frame = 0;
	pass

func run():
#	frame += 1
#	$AnimationPlayer.seek(frame, true)
	current_state.run(controller)

func change_state(state_str, enter):
	print(current_state.name + "\t" + state_str)
	current_state = get_node(state_str)
	
	$AnimationPlayer.play("Rest")
	$AnimationPlayer.advance(1)
	$AnimationPlayer.play(current_state.animation_name(controller))
	current_state.enter(enter)