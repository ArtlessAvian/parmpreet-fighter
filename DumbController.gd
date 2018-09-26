extends Node

var focus = "random"

var buffer = []
var change_buffer = []
const BUFFER_SIZE = 30

func _ready():
	for i in range(0,BUFFER_SIZE):
		buffer.append(5)
		change_buffer.append(5)

func _process(delta):

	var angle = int(floor(randf() * 9) + 1)
	
	if (get_tree().get_frame() % 20 != 0):
		angle = buffer[0]
	else:
		if (randf() < 0.5):
			Input.action_press(focus + "_light")
		if (randf() < 0.5):
			Input.action_press(focus + "_heavy")

	buffer.pop_back()
	buffer.push_front(angle)
#	for i in range(1, 6):
#		if (buffer[i] != 5):
#			break;
#		buffer[i] = angle
	
	if (buffer[0] != buffer[1]):
		change_buffer.pop_back();
		change_buffer.push_front(buffer[0])
	
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