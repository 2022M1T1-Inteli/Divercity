extends Node

signal change_scene

func _construct(mainNode):
	"""
		Node constructor
	"""
	connect("change_scene", mainNode, "_change_scene_to") # Connect callback for local signal
	LevelManager.currentLevel += 1

	for checkpoint in get_node("Checkpoints").get_children():
		if checkpoint.indentifier == LevelManager.currentLevel:
			checkpoint.set_status(true)
		else:
			checkpoint.set_status(false)
