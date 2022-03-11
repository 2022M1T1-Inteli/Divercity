extends Node2D


signal go_to_next_scene

func _construct(mainNode):
	"""
		Node constructor for connect scene.
	"""
	var err = connect("go_to_next_scene", mainNode, "_change_scene_to") # Connect callback for local signal

	if err: # Check for errors
		print("Error connecting signal on Mentor node:", err) # Print error
		return

func _ready():
	var timer = Timer.new() # Create a new timer
	timer.set_wait_time(2) # Set the wait time
	timer.set_one_shot(true) # Set the timer to one shot
	self.add_child(timer) # Add the timer to the scene as a child

	timer.start() # Start the timer
	yield(timer, "timeout") # Wait for the timer to timeout

	timer.call_deferred("free") # Free the timer

	emit_signal("go_to_next_scene", "res://scenes/minigames/golf/Golf.tscn") # Call the change scene to function