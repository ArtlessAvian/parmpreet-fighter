extends Node

var current_state
var controller

func run():
	current_state.run(controller);

func change_state(state_str, enter):
	print(current_state.name + "\t" + state_str)
	current_state = get_node(state_str)
	current_state.enter(enter)