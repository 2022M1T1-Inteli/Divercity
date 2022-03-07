extends Node2D

signal go_to_golf

func _construct(mainNode):
	var err = connect("go_to_golf", mainNode, "_change_scene_to") # Connect callback for local signal

	if err != null: # Check for errors
		print("Error connecting signal on Map node:", err) # Print error
		return