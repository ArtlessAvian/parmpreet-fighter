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

func check_hit():
	var hits = []
	var highest_priority = {"priority":-999}
	
	for hit in $Core.queued_hits:
		hits.push_back(hit)
		if (hit["priority"] > highest_priority["priority"]):
			highest_priority = $Core.queued_hits[hit]
		print("hit!!!")
	
	if (!hits.empty()):
		$StateMachine.set_state("Reel", highest_priority)
	
	for hit in hits:
		$Core.queued_hits.erase(hit)
	

func get_hit():
#	if (hit_promise != -1):
#		hit_promise = -1
	pass