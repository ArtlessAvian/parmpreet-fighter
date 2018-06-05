extends Node

func _ready():
	print(InputMap.get_actions())
	$TestPlayer.enemy = $TestPlayer2
	$TestPlayer2.enemy = $TestPlayer
	$TestPlayer2/Controller.focus = "c0"

func _physics_process(delta):
	if (abs($TestPlayer.position.x - $TestPlayer2.position.x) < 450):
		$Camera2D.position.x = $TestPlayer.position.x
		$Camera2D.position.x += $TestPlayer2.position.x
		$Camera2D.position.x /= 2
	
	if ($TestPlayer.grounded && $TestPlayer2.grounded):
		if ($TestPlayer/Pushbox.overlaps_area($TestPlayer2/Pushbox)):
			var distance = $TestPlayer/Pushbox/CollisionShape2D.shape.extents.x + $TestPlayer2/Pushbox/CollisionShape2D.shape.extents.x
			var pushback = (distance - abs($TestPlayer.position.x - $TestPlayer2.position.x)) / 2
			pushback *= 1/5.0
			$TestPlayer.position.x -= pushback * sign($TestPlayer2.position.x - $TestPlayer.position.x)
			$TestPlayer2.position.x -= pushback * sign($TestPlayer.position.x - $TestPlayer2.position.x)
	
	var camx = $Camera2D.get_camera_screen_center().x
	var a = ($TestPlayer.position.x - camx)
	if (a < -225):
		$TestPlayer.position.x = camx - 225
	elif (a > 225):
		$TestPlayer.position.x = camx + 225
	
	var b = ($TestPlayer2.position.x - camx)
	if (b < -225):
		$TestPlayer2.position.x = camx - 225
	elif (b > 225):
		$TestPlayer2.position.x = camx + 225	
	
	$Camera2D.position.y = min($TestPlayer.position.y, $TestPlayer2.position.y)
	$Camera2D/Label2.text = str($TestPlayer/Controller.change_buffer)