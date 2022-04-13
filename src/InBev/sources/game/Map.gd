extends Node

signal change_scene

var modulateSave = [0.90, 1.05]
var currentCheckpoint = null

func _construct(mainNode):
	"""
		Node constructor
	"""
	connect("change_scene", mainNode, "_change_scene_to") # Connect callback for local signal

func _ready():
	LevelManager.currentLevel += 1 # Increment level

	for checkpoint in get_node("Checkpoints").get_children(): # Get all checkpoints
		if checkpoint.indentifier == LevelManager.currentLevel: # Find the checkpoint for the current level
			checkpoint.set_status(true) # Set checkpoint to active
			currentCheckpoint = checkpoint

			get_node("Tween").interpolate_property(currentCheckpoint, "modulate:a", modulateSave[0], modulateSave[1],  0.5, Tween.TRANS_LINEAR, Tween.EASE_IN) # Create animation
			get_node("Tween").start()
		else:
			checkpoint.set_status(false) # Set checkpoint to inactive
			checkpoint.modulate = Color(0.4, 0.4, 0.4) # Remove effect

	if LevelManager.currentLevel == 5:
		$AnimationPlayer.play("MoveMap")
	elif LevelManager.currentLevel > 5:
		get_node("Map").rect_position = Vector2(620, 0)
		get_node("Checkpoints").position = Vector2(620, 0)

func _on_Tween_tween_all_completed():
	modulateSave.invert() # invert the opacity array
	get_node("Tween").interpolate_property(currentCheckpoint, "modulate:a", modulateSave[0], modulateSave[1],  0.5, Tween.TRANS_LINEAR, Tween.EASE_IN) # Create animation
	get_node("Tween").start()

