extends Area2D

export(int) var customRotations = 0

var currentPosition = 0


const MAX_TILE_SIZE = Vector2(4, 6)

export(Array) var holes = []
export var tilePosition = Vector2(0, 0)
export var canRotate = true

export var format = "DEFAULT"
"""
	DEFAULT - basic default
	CURVED - curved tiles
	STRAIGHT - straight tiles
"""

export var type = "NORMAL"
"""
	NORMAL - basic pipe
	ENTER - start pipe
	EXIT - exit pipe
"""

static func tile_to_position(tile):
	tile.x = MAX_TILE_SIZE.x if tile.x > MAX_TILE_SIZE.x else tile.x # Clamp position.x to defaultSize.x
	tile.y = MAX_TILE_SIZE.y if tile.y > MAX_TILE_SIZE.y else tile.y # Clamp position.y to defaultSize.y

	tile.x = 0 if tile.x < 0 else tile.x # Clamp position.x to 0
	tile.y = 0 if tile.y < 0 else tile.y # Clamp position.y to 0
	return Vector2(72 + (144 * tile.x), 72 + (144 * tile.y)) # Return the position of the tile

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

static func rotate_array(array, direction = 1):
	"""
		Steps the array in the given direction.
		1 = right
		-1 = left
	"""
	direction = direction if direction == 1 or direction == -1 else 1 # Clamp direction to 1 or -1

	direction = -direction # Invert direction for set positive value a right direction

	var movedArray = [] # Create a new array

	for i in range(0, len(array)): # For each element in the array
		movedArray.append(array[(i + direction) % len(array)]) # Add the element of move to the new array

	return movedArray # Return the new array

func _ready():
	rotate_pipe(customRotations)
	set_tile(tilePosition)

	var err = self.connect("input_event", self, "_on_Pipe_input_event") # connect to the input event

	if err: # if there was an error
		print("Error connecting signal on input_event: ", err) # print the error

func get_holes_sides():
	"""
		Returns the sides of the holes in array of vectors.
	"""

	var connects = [] # create a new array to hold the connections vectors

	for outputIdx in range(holes.size()): # for each output
		if holes[outputIdx]: # if there is a connection
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
	if not canRotate: # if the pipe can't rotate
		return

	direction = direction if direction == 1 or direction == -1 else 1 # Clamp direction to 1 or -1
	currentPosition = currentPosition + (90 * direction) # Rotate 90 degrees from current position in direction

	$Tween.interpolate_property(self, "rotation_degrees", self.rotation_degrees, currentPosition, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN) # Rotation animation
	$Tween.start() # Start rotate animation

	holes = rotate_array(holes, direction) # Rotate the holes array

func _on_Pipe_input_event(_viewport, event, _shape_idx): # on input event
	"""
		Callback will be used for handle touch on pipe
	"""
	if event is InputEventScreenTouch and event.is_pressed(): # If has touch event and is pressed
		rotate_pipe() # Rotate pipe

func set_tile(tile):
	"""
		Sets the position of the pipe.
	"""
	self.position = tile_to_position(tile) # Set position
	tilePosition = tile # Set the tile position
	name = "PIPE_%dx%d" % [tilePosition.x, tilePosition.y] # Set the name of the pipe
