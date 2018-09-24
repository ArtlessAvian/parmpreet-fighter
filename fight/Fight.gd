extends Node

func _ready():
	FightInitializer.init_fight(self)
	print("nothing much i guess")
	
	$A1.connect("got_hit", $Camera2D/MarginContainer/PlayerUI, "_update_health");
	$B1.connect("got_hit", $Camera2D/MarginContainer/PlayerUI, "_update_combo");
	$B1.connect("combo_escape", $Camera2D/MarginContainer/PlayerUI, "_on_combo_escape");

	$B1.connect("got_hit", $Camera2D/MarginContainer/PlayerUI2, "_update_health");
	$A1.connect("got_hit", $Camera2D/MarginContainer/PlayerUI2, "_update_combo");
	$A1.connect("combo_escape", $Camera2D/MarginContainer/PlayerUI2, "_on_combo_escape");


func _physics_process(delta):
	if (abs($A1.position.x - $B1.position.x) < 450):
		$Camera2D.position.x = $A1.position.x
		$Camera2D.position.x += $B1.position.x
		$Camera2D.position.x /= 2
	
	var camx = $Camera2D.get_camera_screen_center().x
	var a = ($A1.position.x - camx)
	if (a < -225):
		$A1.position.x = camx - 225
	elif (a > 225):
		$A1.position.x = camx + 225
	
	var b = ($B1.position.x - camx)
	if (b < -225):
		$B1.position.x = camx - 225
	elif (b > 225):
		$B1.position.x = camx + 225
	
	$Camera2D.position.x = clamp($Camera2D.position.x, -600 + 256, 600 - 256)
	
	$Camera2D.position.y = min(-124, min($A1.position.y, $B1.position.y))