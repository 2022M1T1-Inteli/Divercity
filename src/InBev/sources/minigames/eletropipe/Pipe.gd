extends Area2D

var currentPosition = 0

export(Array) var outputs = []

static func get_side_vector(side):
	"""
		Returns the vector of the given side.
		0 = top
		1 = right
		2 = bottom
		3 = left
	"""
	if side == 0:
		return Vector2.UP # top direction
	elif side == 1:
		return Vector2.RIGHT # right direction
	elif side == 2:
		return Vector2.DOWN # bottom direction
	elif side == 3:
		return Vector2.LEFT # left direction
	else:
		return Vector2.ZERO # not implemented

func _ready():
	var err = self.connect("input_event", self, "_on_Pipe_input_event") # connect to the input event

	if err: # if there was an error
		print("Error connecting signal on input_event: ", err) # print the error

func get_output_sides():
	"""
		Returns the sides of the outputs in array of vectors.
	"""

	var connects = [] # create a new array to hold the connections vectors

	for outputIdx in range(outputs.size()): # for each output
		if outputs[outputIdx]: # if there is a connection
			connects.append(get_side_vector(outputIdx)) # add the connection vector to the array

	return connects # return the array of vectors of the connections

func rotate_pipe(direction = 1):
	"""
		Rotates the pipe to direction from the current position.
		Directions:
			1 = right
			-1 = left
			0 = no rotation
	"""
	currentPosition = currentPosition + (90 * direction) # Rotate 90 degrees from current position in direction
	$Tween.interpolate_property(self, "rotation_degrees", self.rotation_degrees, currentPosition, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN) # Rotation animation
	$Tween.start() # Start rotate animation

func _on_Pipe_input_event(_viewport, event, _shape_idx): # on input event
	"""
		Callback will be used for handle touch on pipe
	"""
	if event is InputEventScreenTouch and event.is_pressed(): # If has touch event and is pressed
		rotate_pipe() # Rotate pipe
