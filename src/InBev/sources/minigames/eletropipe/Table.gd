extends Node2D

export(Vector2) var size = Vector2.ZERO

class BasePipe:
	var rotation = 0
	var type = 0
	var position = Vector2.ZERO

	var defaultSize = Vector2.ZERO

	func _init(size):
		defaultSize = size # Set default size

	func rotate(direction):
		"""
			Rotates the pipe to direction.
			Directions:
				1 = right
				-1 = left
				0 = no rotation
		"""
		rotation = direction + (90 * direction) # Add 90 degrees to direction to make it relative to the pipe

	func set_position(position):
		"""
			Sets the position of the pipe.
		"""
		position.x = defaultSize.x if position.x > defaultSize.x else position.x # Clamp position.x to defaultSize.x
		position.y = defaultSize.y if position.y > defaultSize.y else position.y # Clamp position.y to defaultSize.y
		self.position = position # Set position

func _ready():
	pass

static func get_pipe_type_name(type):
	"""
		Return the name of the pipe type.
		0 = straight
		1 = curved
	"""

	if type == 0:
		return "Straight" # Straight pipe
	elif type == 1:
		return "Curved" # Curved pipe
	elif type == 2:
		return "" # Empty pipe
	else:
		return "Unknown" # not implemented

func is_pipes_connected():
	pass

func init_energy_system():
	pass

func get_pipe_from_position(position):
	"""
		Returns the pipe at the given position.
		If there is no pipe at the given position, returns null.
	"""
	return get_node_or_null(("Pipe_%dx%d" % [position.x, position.y])) # Return the pipe at the given position.

func get_next_pipe_from_direction(position, direction):
	"""
		Returns the next pipe in the given direction.
		If there is no pipe in the given direction, returns null.
	"""
	return get_pipe_from_position(position + direction) # Return the pipe in the given direction from position.

func get_all_pipes():
	"""
		Returns all pipes in the table.
	"""
	var pipes = [] # Create a list to store all pipes.

	for xIdx in range(size.x): # For each x index.
		for yIdx in range(size.y): # For each y index.
			pipes.append(get_pipe_from_position(Vector2(xIdx, yIdx))) # Add the pipe at the given position to the list.

	return pipes # Return all pipes in the game.
