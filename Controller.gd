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
	
	for i in range(1, 10):
		print(flip_key_num(i))

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
#	for i in range(1, 6):
#		if (buffer[i] != 5):
#			break;
#		buffer[i] = angle
	buffer.pop_back()
	
	if (buffer[0] != buffer[1]):
		change_buffer.push_front(buffer[0])
		change_buffer.pop_back();
	
func dir():
	return buffer[0]

func flip_key_num(key):
	# couldve used a dictionary ig
	return key - 2 * (((key - 1) % 3) - 1)

func detect_motion(nums, flipped, leeway = 7):
	
	if (nums.length() * leeway > BUFFER_SIZE):
		print("[Controller]: The input buffer is a bit small!")
	elif (nums.length() * leeway > BUFFER_SIZE):
		printerr("[Controller]: The input buffer is too small!")
		print_stack()
	
	# Last key pressed should be pressed when called
	if (!flipped && int(nums[nums.length()-1]) != buffer[0]):
		return false
	if (flipped && int(nums[nums.length()-1]) != flip_key_num(buffer[0])):
		return false
	
	var cursor = -1
	for index in range(nums.length()-1, -1, -1):
		
		var incomplete = true
		for attempt in range(0, leeway):
			cursor += 1
			
			if (cursor >= BUFFER_SIZE):
				# safety!
				return false
				
			if (!flipped && buffer[cursor] == int(nums[index])):
				incomplete = false
				break
				
			if (flipped && buffer[cursor] == flip_key_num(int(nums[index]))):
				incomplete = false
				break
				
		if (incomplete):
			# run if the cursor never found a key continuing the motion
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
#
#func is_qcf():
#	return detect_motion("236", 10)
#
#func is_qcb():
#	return detect_motion("214", 10)