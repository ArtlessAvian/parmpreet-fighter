extends "AirState.gd"

export var dash_time = 10
var frame_num = 0

func _run(subject, controller):
	if (frame_num >= dash_time):
		if (controller.dir() != 5):
			return self.air_action(subject, controller)
	
	else:
		print(frame_num)
		frame_num += 1
		subject.vel.y -= 0.5

func _enter(subject, controller, old_state, args):
	frame_num = 0;
	print("airdash")
	subject.vel.y = 0
	subject.vel.x = (controller.dir() - 5) * 7