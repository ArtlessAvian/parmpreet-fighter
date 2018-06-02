extends Node

var focus = "kb"

var buffer = []
const BUFFER_SIZE = 30

func _ready():
	for i in range(0,BUFFER_SIZE):
		buffer.append(5)

func _process(delta):
	var angle = 5
	if (Input.is_action_pressed(focus + "_up")):
		angle += 3
	if (Input.is_action_pressed(focus + "_down")):
		angle -= 3
	if (Input.is_action_pressed(focus + "_left")):
		angle -= 1
	if (Input.is_action_pressed(focus + "_right")):
		angle += 1
	
	buffer.push_front(angle)
	buffer.pop_back()

func detect_motion(nums):
	var cursor = -1
	for index in range(nums.length()-1, 0, -1):
		
		var fail = true
		for attempt in range(0,10):
			cursor += 1
			if (cursor >= BUFFER_SIZE):
				return false
			if (buffer[cursor] == int(nums[index])):
				fail = false
				break
		if (fail):
			return false
			
	return true

func is_qcf():
	return detect_motion("236")

func is_qcb():
	return detect_motion("214")