extends Node2D

signal go_to_next_scene

func _construct(mainNode):
	"""
		Node constructor for connect scene.
	"""
	var err = connect("go_to_next_scene", mainNode, "_change_scene_to") # Connect callback for local signal

	if err: # Check for errors
		print("Error connecting signal on Map node:", err) # Print error
		return