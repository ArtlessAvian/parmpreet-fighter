extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var enemy = null
var vel = Vector2();
var grounded = true
var max_air_actions = 3
var air_action = max_air_actions

func _ready():
	$StateMachine.controller = $Controller
	$StateMachine.subject = self
	$StateMachine.current_state = $StateMachine/Stand
	self.set_physics_process(true)

func _physics_process(delta):
	$StateMachine.run()
	self.position += vel
	
	if (!grounded):
		self.vel.y += 0.5
		if (self.position.y >= 0):
			self.vel *= 0
			grounded = true
			air_action = max_air_actions
			grounded_check($Controller)

func grounded_check(controller):
	
	if (scale.x * (enemy.position.x - position.x) < 0):
		scale.x *= -1
	
	if (controller.dir() >= 7):
		$StateMachine.change_state("Jump", controller.dir())
		return
	
	# Supers
	
	# Special Attacks
	
	# Attacks
	
#	if (controller.dir() <= 3):
#		$StateMachine.change_state("Crouch")

	# Dash
	if (self.scale.x == 1 && controller.detect_motion("656", 10)):
		$StateMachine.change_state("Dash", controller.dir())
		return
	if (self.scale.x == -1 && controller.detect_motion("454", 10)):
		$StateMachine.change_state("Dash", controller.dir())
		return

	if (controller.dir() == 6 || controller.dir() == 4):
		
		if ((controller.dir() == 6) == (self.scale.x == 1)):
			$StateMachine.change_state("Walk", controller.dir())
		else:
			$StateMachine.change_state("BackWalk", controller.dir())
		return
			
	$StateMachine.change_state("Stand", null)