extends Node

func _ready():
	FightInitializer.init_fight(self)
	print("nothing much i guess")
	
	$TeamA/A1.connect("got_hit", $Camera2D/MarginContainer/PlayerUI, "_update_health");
	$TeamB/B1.connect("got_hit", $Camera2D/MarginContainer/PlayerUI, "_update_combo");
	$TeamB/B1.connect("combo_escape", $Camera2D/MarginContainer/PlayerUI, "_on_combo_escape");

	$TeamB/B1.connect("got_hit", $Camera2D/MarginContainer/PlayerUI2, "_update_health");
	$TeamA/A1.connect("got_hit", $Camera2D/MarginContainer/PlayerUI2, "_update_combo");
	$TeamA/A1.connect("combo_escape", $Camera2D/MarginContainer/PlayerUI2, "_on_combo_escape");


func _physics_process(delta):
	if (abs($TeamA/A1.position.x - $TeamB/B1.position.x) < 450):
		$Camera2D.position.x = $TeamA.get_child(0).position.x
		$Camera2D.position.x += $TeamB.get_child(0).position.x
		$Camera2D.position.x /= 2
	
	var camx = $Camera2D.get_camera_screen_center().x
	var a = ($TeamA.get_child(0).position.x - camx)
	if (a < -225):
		$TeamA.get_child(0).position.x = camx - 225
	elif (a > 225):
		$TeamA.get_child(0).position.x = camx + 225
	
	var b = ($TeamB.get_child(0).position.x - camx)
	if (b < -225):
		$TeamB.get_child(0).position.x = camx - 225
	elif (b > 225):
		$TeamB.get_child(0).position.x = camx + 225
	
	$Camera2D.position.x = clamp($Camera2D.position.x, -600 + 256, 600 - 256)
	
	$Camera2D.position.y = min(-124, min($TeamA.get_child(0).position.y, $TeamB.get_child(0).position.y))
