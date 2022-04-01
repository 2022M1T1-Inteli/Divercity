extends Node

signal change_scene

func _construct(mainNode):
	"""
		Node constructor
	"""
	connect("change_scene", mainNode, "_change_scene_to") # Connect callback for local signal
	LevelManager.currentLevel += 1 # Increment level

	for checkpoint in get_node("Checkpoints").get_children(): # Get all checkpoints
		if checkpoint.indentifier == LevelManager.currentLevel: # Find the checkpoint for the current level
			checkpoint.set_status(true) # Set checkpoint to active
		else:
			checkpoint.set_status(false) # Set checkpoint to inactive

	if LevelManager.currentLevel >= 4:
		$Tween.interpolate_property(get_node("Map"), "modulate", 0, 640,  3,  Tween.TRANS_LINEAR, Tween.EASE_IN) # Create animation
		$Tween.start() # Create animation
