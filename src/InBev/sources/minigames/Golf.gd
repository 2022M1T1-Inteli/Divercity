extends Node

func _ready():
	load_map(1) # Load example first map

func load_map(map_id):
	var map_instance = load("res://scenes/MiniGames/Golf/Maps/Level_%d.tscn" % map_id).instance() # Copy a instance of map from the resource
	map_instance.z_index = -1 # Set the z-index of the map to -1 so it's behind all scene
	add_child(map_instance) # Add the map to the scene as a child
