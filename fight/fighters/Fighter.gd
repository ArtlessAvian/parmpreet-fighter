extends Node2D

export (PackedScene) var my_core = null
export (PackedScene) var my_state_machine = null
var enemy = null

var vel = Vector2(0,0)
var grounded = true
var air_action = 2

func _ready():
	get_node("Core").replace_by_instance(my_core)
	get_node("StateMachine").replace_by_instance(my_state_machine)
	get_node("StateMachine").observers.push_back(get_node("Core/AnimationPlayer"))

func _physics_process(delta):
	move(delta)
	check_hit()
	get_hit()

func move(delta):
	position += vel
	if (!grounded):
		vel.y += 0.5
		if (position.y > 0):
			grounded = true
			position.y = 0
			vel.y = 0
			air_action = 2
			$StateMachine.set_state("Stand")

var hit_promise = -1
func check_hit():
	if (get_node("Core/Hitboxes").get_overlapping_areas().size() > 0):
		print("im hit")
#		hit_promise = 0;

func get_hit():
#	if (hit_promise != -1):
#		hit_promise = -1
	pass