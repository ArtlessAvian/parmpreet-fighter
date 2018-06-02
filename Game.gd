extends Node

func _ready():
	print(InputMap.get_actions())
	$TestPlayer.enemy = $TestPlayer2
	$TestPlayer2.enemy = $TestPlayer
	$TestPlayer2/Controller.focus = "ahhh"

func _physics_process(delta):
	$Camera2D.position.x = $TestPlayer.position.x
	$Camera2D.position.x += $TestPlayer2.position.x
	$Camera2D.position.x /= 2
	$Camera2D.position.y = max($TestPlayer.position.y, $TestPlayer2.position.y)
	$Camera2D/Label2.text = str($TestPlayer/Controller.change_buffer)