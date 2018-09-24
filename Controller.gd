extends Node

var focus = "kb"

var buffer = []
var change_buffer = []
const BUFFER_SIZE = 30

func _ready():
	Player2.focus = "c0"
	
	for i in range(0,BUFFER_SIZE):
		buffer.append(5)
		change_buffer.append(5)

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
	
	if (buffer[0] != buffer[1]):
		change_buffer.push_front(buffer[0])
		change_buffer.pop_back();
	
func dir():
	return buffer[0]

func detect_motion(nums, leeway):
	if (int(nums[nums.length()-1]) != buffer[0]):
		return false
	
	var cursor = -1
	for index in range(nums.length()-1, -1, -1):
		
		var fail = true
		for attempt in range(0, leeway):
			cursor += 1
			if (cursor >= BUFFER_SIZE):
				return false
			if (buffer[cursor] == int(nums[index])):
				fail = false
				break
		if (fail):
			return false
			
	return true

#func trace_motion(nums, leeway):
#	var trace = ""
#	if (int(nums[nums.length()-1]) != buffer[0]):
#		return buffer[0] + " FAIL"
#
#	var cursor = -1
#	for index in range(nums.length()-1, -1, -1):
#
#		var fail = true
#		for attempt in range(0, leeway):
#			cursor += 1
#			if (cursor >= BUFFER_SIZE):
#				return trace + " TOO SLOW"
#			trace = trace + str(buffer[cursor])
#			if (buffer[cursor] == int(nums[index])):
#				fail = false
#				break
#		if (fail):
#			return trace + " FAIL"
#
#	return trace + " SUCC"

func is_qcf():
	return detect_motion("236", 10)

func is_qcb():
	return detect_motion("214", 10)