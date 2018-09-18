extends Node

func _ready():
	FightInitializer.init_fight(self)
	print("nothing much i guess")

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
	
	$Camera2D.position.y = min($A1.position.y, $B1.position.y)