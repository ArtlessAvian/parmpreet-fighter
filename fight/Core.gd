extends Node2D

var hitstop = 0

var have_hit = false
var queued_hits = {}
export (int) var damage = 10
export (int) var knockback = 40
export (int) var hitstun = 20
export (int) var priority = 0

func _queue_hit(area):
	queued_hits[area] = {"hitter":area.get_parent(), "priority":area.get_parent().priority, "knockback":area.get_parent().knockback, "hitstun":area.get_parent().hitstun, "damage":area.get_parent().damage}
	pass # replace with function body

func _dequeue_hit(area):
	print("---------------- hey this actually happens")
	if queued_hits.has(area):
		queued_hits.erase(area)
	pass # replace with function body

func _on_Hurtboxes_area_exited(area):
	pass # replace with function body


func _on_StateMachine_new_state(state_str):
	print("recieved!")
	$AnimationPlayer.set_state(state_str)
	print("handled!")