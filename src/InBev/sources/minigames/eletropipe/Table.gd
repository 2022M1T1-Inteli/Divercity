extends Node2D

const MAX_TILE_SIZE = Vector2(4, 6)

const PIPES_TYPE = {
	ENTER = "ENTER",
	PATH = "NORMAL",
	EXIT = "EXIT"
}

const PIPES_NAME = {
	DEFAULT = "PIPE_"
}


onready var pipeCurvedScene = preload("res://scenes/minigames/eletropipe/bases/PipeCurved.tscn")
onready var pipeStraightScene = preload("res://scenes/minigames/eletropipe/bases/PipeStraight.tscn")

func is_pipes_path_connected():
	"""
		Return True if the pipes are connected.
	"""
	var currentPipeTrack = get_pipe_enter() # Get the current pipe track
	var endPipe = get_pipe_exit() # get the exit pipe

	var trackList = [] # list of track

	var nextDirection = Vector2.ZERO # The direction of the next pipe
	var lastDirection = Vector2.ZERO # The direction of the last pipe

	for _pipe in self.get_children(): # Limit the search to the pipes with the numbers of pipes
		trackList.append(currentPipeTrack) # Add the current pipe track to the list

		for outerDirection in currentPipeTrack.get_holes_sides(): # Get the outer direction of the current pipe
			if outerDirection * -1 == lastDirection: # If the direction is the same as the last direction
				continue

			var dumpPipe = get_next_pipe_from_direction(currentPipeTrack.tilePosition, outerDirection) # Get the next pipe from the direction

			if dumpPipe == null:# Check if pipe exist
				continue

			for innerDirection in dumpPipe.get_holes_sides(): # Get the inner direction of the next pipe
				if innerDirection * -1 == outerDirection: # If the direction is the same as the outer direction
					nextDirection = outerDirection # Set the next direction
					break

			if nextDirection != Vector2.ZERO: # Check if the next direction is not zero and break outer loop
				break

		if nextDirection == Vector2.ZERO: # Check if the next direction is zero
			print("[Eletropipe] NOT CONNECT: Next direction not found.")
			return false

		currentPipeTrack = get_next_pipe_from_direction(currentPipeTrack.tilePosition, nextDirection) # Get the next pipe

		if currentPipeTrack == null:
			print("[Eletropipe] NOT CONNECT: The pipes are not connected to continue.")
			return false

		elif currentPipeTrack == endPipe:
			print("[Eletropipe] CONNECTED: The pipes are connected!.")
			return true

		lastDirection = nextDirection # Set the last direction
		nextDirection = Vector2.ZERO # Reset the next direction

func create_pipe(style, tilePosition):
	"""
		Create a pipe with the given position and type.
		Style: The style of the pipe: 'curved' or 'straight'.
		TilePosition: The position of the pipe.
	"""
	var pipe = null # The pipe to be created

	if style == "curved": # If the style is curved
		pipe = pipeCurvedScene.instance() # Create the pipe
	elif style == "straight": # If the style is straight
		pipe = pipeStraightScene.instance() # Create the pipe

	pipe.tilePosition = tilePosition # Set the position of the pipe
	return pipe # Return the pipe

func get_random_seed():
	"""
		Return a random seed.
	"""
	var rng = RandomNumberGenerator.new() # Create a new random number generator
	rng.randomize() # Randomize the number generator
	return rng.randi() # Return a random integer

#func generate_random_pipes_path():
#	"""
#		Generate the pipes path with correct connetions.
#	"""
#	# Create pipes path with the correct connections in enter and exit pipes
#	var enterPipe = get_pipe_enter() # Get the current pipe track
#	var endPipe = get_pipe_exit() # get the exit pipe

#	var trackList = [] # List of track

#	for _i in range(MAX_TILE_SIZE.x * MAX_TILE_SIZE.y):
#		var pipe

func init_energy_system():
	pass

func get_pipe_enter():
	"""
		Return the pipe at the entrance.
	"""
	for pipe in self.get_children(): # Search for the pipe at the entrance
		if pipe.type == PIPES_TYPE.ENTER: # If the pipe is at the entrance
			return pipe # Return the pipe at the entrance
	return null # Return null if there is no pipe at the entrance


func get_pipe_exit():
	"""
		Return the pipe at the exit.
	"""
	for pipe in self.get_children(): # Search for the pipe at the exit
		if pipe.type == PIPES_TYPE.EXIT: # If the pipe is at the exit
			return pipe # Return the pipe at the exit
	return null # Return null if there is no pipe at the exit

func get_pipe_from_tile(tile):
	"""
		Returns the pipe at the given tile position.
		If there is no pipe at the given position, returns null.
	"""
	return get_node_or_null(PIPES_NAME.DEFAULT + ("%dx%d" % [tile.x, tile.y])) # Return the pipe at the given position.

func get_next_pipe_from_direction(tile, direction):
	"""
		Returns the next pipe in the given direction.
		If there is no pipe in the given direction, returns null.
	"""
	return get_pipe_from_tile(tile + direction) # Return the pipe in the given direction from position.

func get_all_pipes():
	"""
		Returns all pipes in the table.
	"""
	var pipes = [] # Create a list to store all pipes.

	for xIdx in range(MAX_TILE_SIZE.x): # For each x index.
		for yIdx in range(MAX_TILE_SIZE.y): # For each y index.
			pipes.append(get_pipe_from_tile(Vector2(xIdx, yIdx))) # Add the pipe at the given position to the list.

	return pipes # Return all pipes in the game.


func _on_Button_pressed():
	print(is_pipes_path_connected())
