extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var enemy = null
var vel = Vector2();
var grounded = true
var max_air_actions = 2
var air_action = max_air_actions

func _ready():
	$StateMachine.controller = $Controller
	$StateMachine.subject = self
	$StateMachine.current_state = $StateMachine/Stand
	self.set_physics_process(true)

func _physics_process(delta):
	$StateMachine.run()
	self.position += vel
	
	if ($Hitboxes.overlaps_area(enemy.get_node("Hurtboxes"))):
		print("ayo")
	
	if (!grounded):
		self.vel.y += 0.5
		if (self.position.y >= 0):
			self.position.y = 0
			self.vel *= 0
			grounded = true
			air_action = max_air_actions
			grounded_check($Controller)

func grounded_check(controller):
	reset_hitboxes()
	
	if (scale.x * (enemy.position.x - position.x) < 0):
		scale.x *= -1
	
	if (controller.dir() >= 7):
		$StateMachine.change_state("Jump", controller.dir())
		return true
	
	# Supers
	
	# Special Attacks
	
	# Attacks
	
	if (controller.dir() <= 3):
		$StateMachine.change_state("Crouch", null)
		return true

	# Dash
	if (self.scale.x == 1 && controller.detect_motion("656", 10)):
		$StateMachine.change_state("Dash", controller.dir())
		return true
	if (self.scale.x == -1 && controller.detect_motion("454", 10)):
		$StateMachine.change_state("Dash", controller.dir())
		return true

	if (controller.dir() == 6 || controller.dir() == 4):
		
		if ((controller.dir() == 6) == (self.scale.x == 1)):
			$StateMachine.change_state("Walk", controller.dir())
		else:
			$StateMachine.change_state("BackWalk", controller.dir())
		return true
			
	$StateMachine.change_state("Stand", null)
	return true

func air_action(controller):
	if (air_action <= 0):
		return false
	
	if (controller.dir() >= 7):
		$StateMachine.change_state("DoubleJump", controller.dir())
		air_action -= 1
		return true
	
	if (controller.detect_motion("454", 10) || controller.detect_motion("656", 10) ||
	  controller.detect_motion("754", 10) || controller.detect_motion("956", 10)):
		$StateMachine.change_state("AirDash", controller.dir())
		air_action -= 1
		return true

func reset_hitboxes():
	for hitbox in $Hitboxes.get_children():
		hitbox.scale.x = 0;
		hitbox.scale.y = 0;
		hitbox.disabled = true;