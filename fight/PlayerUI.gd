extends VBoxContainer

export (bool) var right_player = false

func _ready():
	if (right_player):
		recurse_reverse(self)

# name is cool af tbh
func recurse_reverse(node):
	var children = node.get_children()
	
	for child in children:
		recurse_reverse(child)
	
	if (node is HBoxContainer):
		node.alignment = ALIGN_END
		for child in children:
			node.move_child(child, 0);
	
	if (node is Label):
		node.align = ALIGN_END

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _update_health(health, enemy_combo):
	$Health.text = "OOOOOOOOOOOOOOOOOOOO".substr(0, health)

func _update_combo(health, enemy_combo):
#	if (enemy_combo > 1):
	$Combo.text = str(enemy_combo) + " Combo!"

func _on_combo_escape():
	$Combo.text = ""