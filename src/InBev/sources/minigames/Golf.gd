extends Node

func _ready():
	load_map(1)

func load_map(map_id):
	var map_instance = load("res://scenes/MiniGames/Golf/Maps/Level_%d.tscn" % map_id).instance()
	map_instance.z_index = -1
	add_child(map_instance)
