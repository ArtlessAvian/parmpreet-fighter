extends Node

var FIGHT = preload("res://fight/Fight.tscn")

func _unhandled_key_input(event):
	FightInitializer.a1_id = 0
	FightInitializer.b1_id = 0
	get_tree().change_scene_to(FIGHT)
