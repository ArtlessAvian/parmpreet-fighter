extends "res://StateMachine.gd".State

export (String) var attack_pool = ""

# Can combo an attack into an attack of higher priority.
# For a zig zag magic series, just go 0 1 2 3 4 5 6.
# For the other thing i cant remember, go 1 1 3 3 5 5 7 7

# 0 light, 2 medium, 4 heavy, 6 special, 8 motion inputs, 9 super.
export (int, -1, 9) var priority = -1

func try_attack(subject, controller):
	
	var light_pressed = Input.is_action_just_pressed(controller.focus + "_light")
	var heavy_pressed = Input.is_action_just_pressed(controller.focus + "_medium")
	
	if (!light_pressed and !heavy_pressed):
		return ""
		
#	for subject.supers
#		check
#			goto
	
	for motion in subject.motions.keys():
		if (controller.detect_motion(motion, subject.scale.x < 0, 6)):
			print("detected " + motion)
			return subject.motions[motion]
#	
	
#	if (priority < 6 and Input.is_action_just_pressed(controller.focus + "_heavy")):
#		if (self.name != (attack_pool + "Heavy")):
#			return attack_pool + "Heavy"
#	if (priority < 4 and Input.is_action_just_pressed(controller.focus + "_medium")):
#		if (self.name != (attack_pool + "Medium")):
#			return attack_pool + "Medium"
	if (priority < 4 and heavy_pressed):
		if (self.name != (attack_pool + "Heavy")):
			return attack_pool + "Heavy"
	if (priority < 2 and light_pressed):
		if (self.name != (attack_pool + "Light")):
			return attack_pool + "Light"
#	if (Input.is_action_just_pressed(controller.focus + "_light")):
#		return attack_pool + "Light"
#	etc. etc.
#
#	put high priority in front
	return ""