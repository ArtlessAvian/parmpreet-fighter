extends Node
signal new_state

class State:
	extends Node
	
	func _enter(subject, controller, old_state, args): return
	func _exit(subject, controller, state_str): return
	# return a state name to change state
	func _run(subject, controller): return

var subject = null
var controller = null
onready var current_state = get_child(0);

var observers = [];

export (NodePath) var subjectPath = ".."

func _ready():
	subject = get_node(subjectPath)

func _physics_process(delta):
	var transition = current_state._run(subject, controller)
	if (transition != null):
		set_state(transition)

func set_state(state_str, args={}):
	
	for observer in observers:
		observer.call("set_state", state_str)
	
	var old_state = current_state
	
	var exiting = current_state._exit(subject, controller, state_str)
	if (exiting):
		args["exiting"] = exiting
		
	current_state = find_node(state_str)
	current_state._enter(subject, controller, old_state, args)