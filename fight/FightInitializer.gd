extends Node

var a1_id = -1
var a2_id = -1
var b1_id = -1
var b2_id = -1

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
	b1.get_node("StateMachine").controller = Player2
	
	a1.position.x = -100
	b1.position.x = 100
	
	a1.enemy = b1
	b1.enemy = a1
	
	flip_collision(b1)

func flip_collision(p2):
#	2^0 + 2^10	
	p2.get_node("Core/Hitboxes").collision_layer = (1025) ^ p2.get_node("Core/Hitboxes").collision_layer
	
#	2^20 - 1 == 2^0 + 2^1 + 2^2 ... 2^19
	p2.get_node("Core/Hurtboxes").collision_mask = (1048575) ^ p2.get_node("Core/Hitboxes").collision_mask