extends Node

var currentMap
var shotsCounter = 0

export var loadMap = 1
export(String) var callbackScenePath
export(Dictionary) var callbackSceneParams

signal change_scene # Create local signal for change to game scene

func _construct(mainNode):
	"""
		Node constructor
	"""
	connect("change_scene", mainNode, "_change_scene_to") # Connect callback for local signal

func _ready():
	VisualServer.set_default_clear_color(Color("#3A893D")) # Change default background color
	load_map(loadMap) # Load example first map
	currentMap.get_node("Hole").connect("golfball_entered", self, "on_golfball_entered") # Connect to the hole node

func add_shot():
	"""
		Add shot to the count and update label of self
	"""

	shotsCounter += 1
	$Interface/CountLabel.text = "Tacadas realiazadas: %d" % shotsCounter

func load_map(map_id):
	"""
		Loads a map from the map id.
		default map id: Level_{ID}
	"""
	var mapInstance = load("res://scenes/minigames/golf/maps/Level_%d.tscn" % map_id).instance() # Copy a instance of map from the resource
	mapInstance.z_index = -1 # Set the z-index of the map to -1 so it's behind all scene
	add_child(mapInstance) # Add the map to the scene as a child
	currentMap = mapInstance # Set the current map to the new map

func on_golfball_entered():
	$GolfBall._anim_enter_hole(currentMap.get_node("Hole")) # Play the animation of the golf ball entering the hole

	$GolfBall/GolfBallAudioPlayer.play_win_sound() # Play the win sound

	var timer = Timer.new() # Create a new timer
	timer.set_wait_time(1.5) # Set the wait time
	timer.set_one_shot(true) # Set the timer to one shot
	add_child(timer) # Add the timer to the scene as a child

	timer.start() # Start the timer
	yield(timer, "timeout") # Wait for the timer to timeout

	timer.call_deferred("free") # Free the timer

	$GolfBall.call_deferred("free") # Free the golf ball

	emit_signal("change_scene", callbackScenePath, true, callbackSceneParams) # Emit the change scene signal to the game scene
