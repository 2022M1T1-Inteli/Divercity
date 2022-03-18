extends Node

signal change_scene

func _construct(mainNode):
	connect("change_scene", mainNode, "_change_scene_to") # Connect callback for local signal
