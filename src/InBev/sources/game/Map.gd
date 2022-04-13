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
			checkpoint.set_status(true) # Set checkpoint to active but with no effect
			checkpoint.modulate = Color(0.4, 0.4, 0.4) # Remove effect

	if LevelManager.currentLevel >= 5:
		$AnimationPlayer.play("MoveMap")


func _ready():
	$BlinkAnimationPlayer.play("BlinkCheckpoints")
