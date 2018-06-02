extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var enemy = null
var vel = Vector2();
var grounded = true

func _ready():
	$StateMachine.controller = $Controller
	for state in $StateMachine.get_children():
		state.subject = self
	$StateMachine.current_state = $StateMachine/Stand
	self.set_physics_process(true)

func _physics_process(delta):
	$StateMachine.run()
	self.position += vel
	
	if (!grounded):
		self.vel.y += 1
		if (self.position.y >= 0):
			self.vel *= 0
			grounded = true
			grounded_check($Controller)

func grounded_check(controller):
	
	if (controller.dir() >= 7):
		$StateMachine.change_state("Jump", controller.dir())
		return
	
#	if (controller.dir() <= 3):
#		$StateMachine.change_state("Crouch")

	if (controller.dir() == 6 || controller.dir() == 4):
		if ((controller.dir() == 6) == (self.scale.x == 1)):
			$StateMachine.change_state("Walk", controller.dir())
		else:
			$StateMachine.change_state("BackWalk", controller.dir())
		return
			
	$StateMachine.change_state("Stand", null)