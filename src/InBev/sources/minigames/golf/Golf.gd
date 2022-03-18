extends Node

var currentMap
export var loadMap = 1

func _ready():
	VisualServer.set_default_clear_color(Color("#3A893D")) # Change default background color
	load_map(loadMap) # Load example first map
	currentMap.get_node("Hole").connect("golfball_entered", self, "on_golfball_entered") # Connect to the hole node

func load_map(map_id):
	var map_instance = load("res://scenes/minigames/golf/maps/Level_%d.tscn" % map_id).instance() # Copy a instance of map from the resource
	map_instance.z_index = -1 # Set the z-index of the map to -1 so it's behind all scene
	add_child(map_instance) # Add the map to the scene as a child
	currentMap = map_instance # Set the current map to the new map

func on_golfball_entered():
	$GolfBall._anim_enter_hole(currentMap.get_node("Hole")) # Play the animation of the golf ball entering the hole

	$GolfBall/GolfBallAudioPlayer.play_win_sound() # Play the win sound

	var timer = Timer.new() # Create a new timer
	timer.set_wait_time(1.5) # Set the wait time
	timer.set_one_shot(true) # Set the timer to one shot
	self.add_child(timer) # Add the timer to the scene as a child

	timer.start() # Start the timer
	yield(timer, "timeout") # Wait for the timer to timeout

	timer.call_deferred("free") # Free the timer

	$GolfBall.call_deferred("free") # Free the golf ball
