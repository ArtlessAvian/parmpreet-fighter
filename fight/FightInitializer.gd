extends Node

var a1_id = 0
var a2_id = 0
var b1_id = 0
var b2_id = 0

var fighters = {
	0 : preload("res://fight/fighters/testguy/Test Guy.tscn")
}

func init_fight(fight_node):
	print("hey wassup")
	
	fight_node.get_node("A1").replace_by_instance(fighters[a1_id])
	fight_node.get_node("B1").replace_by_instance(fighters[b1_id])
	
	var a1 = fight_node.get_node("A1")
	var b1 = fight_node.get_node("B1")
	
	a1.get_node("StateMachine").controller = Player1
#	b1.get_node("StateMachine").controller = Player2
	b1.get_node("StateMachine").controller = DumbController
	
	a1.position.x = -100
	b1.position.x = 100
	
	a1.enemy = b1
	b1.enemy = a1
	
	flip_collision(b1)
	
	b1.get_node("Core/Sprite").add_child(load("res://fight/fighters/testguy/Angery.tscn").instance())

func flip_collision(p2):
	# opposite of default
	p2.get_node("Core/Hitboxes").collision_layer = 1
	p2.get_node("Core/Hurtboxes").collision_mask = 1047552