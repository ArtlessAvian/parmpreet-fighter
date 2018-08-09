extends Node2D

export (PackedScene) var my_core = null
var enemy = null

var vel = Vector2(0,0)
var grounded = true
var air_action = 2

func _ready():
	get_node("Core").replace_by_instance(my_core)
	get_node("StateMachine").set_state("Stand")
	get_node("StateMachine").observers.push_back(get_node("Core/AnimationPlayer"))

func _physics_process(delta):
	position += vel
	if (!grounded):
		vel.y += 0.5
		if (position.y > 0):
			grounded = true
			position.y = 0
			vel.y = 0
			air_action = 2
			$StateMachine.set_state("Stand")