extends Node2D

signal go_to_golf

func _construct(mainNode):
	connect("go_to_golf", mainNode, "_change_scene_to") # Connect callback for local signal
