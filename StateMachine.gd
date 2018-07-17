extends Node
signal new_state

class State:
	func _enter(subject, old_state): return
	func _exit(subject, state_str): return
	# return a state name to change state
	func _run(subject, controller): return
	func _is_static(): return false

# Cannot export dictionary, which would be the best practice I suppose.
var states = {}
var subject = null
var controller = null
var current_state = State.new()

# Implementation Stuff
export (String) var statesListFile
export (String) var defaultPath = "res://"
export (NodePath) var subjectPath = null

func _ready():
	# Jank because dictionary exporty stuff ig
	if (statesListFile != null):
		var file = File.new()
		file.open(statesListFile, File.READ)
		var result = JSON.parse(file.get_as_text())
		states = result.result

	for key in states:
		if (states[key] == ""):
			states[key] = defaultPath

		states[key] = load(states[key] + key + ".gd")

	subject = get_node(subjectPath)

# Actual State Machine Part -----------------------------------------------

func _physics_process(delta):
	var transition = current_state._run(subject, controller)
	if (transition != null):
		set_state(transition)

func set_state(state_str):
	var old_state = current_state
	current_state._exit(subject, state_str)
	current_state = new_state_instance(state_str)
	current_state._enter(subject, old_state)
	
	# Keep the object for later use in the same dictionary
	if (current_state._is_static()):
		states[state_str] = current_state

func new_state_instance(state_str):
	print(state_str)
	if (states[state_str] is GDScript):
		return states[state_str].new()
	else:
		print("Static")
		return states[state_str]