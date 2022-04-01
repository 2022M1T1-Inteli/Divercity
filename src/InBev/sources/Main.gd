extends Node

onready var currentNode = get_node("BaseReplaceNode") # get current template node

var onChangingScene = false

func _ready():
	VersionManager.version = "1.3.0" # set version
	LevelManager.currentLevel = 1 # set level to -1
	_change_scene_to("res://scenes/menu/Menu.tscn", false) # Add the menu scene to the scene stack

func _change_scene_to(scene, fade = true, params = {}): # Callback to change scene from childs
	"""
		Change the scene to the given scene.
		If fade is true, the scene will fade out and fade in.
		If fade is false, the scene will be switched instantly.
		If params is given, it will be passed to the scene.
	"""
	if onChangingScene: # Return if the scene is already changing
		return

	onChangingScene = true # Set the scene changing flag
	if fade: # If need fade
		## In fade

		# Set propriety of the fade transition node
		$FadeAnimator.interpolate_property(get_node("CanvasLayer/Overlay"), "color", Color(0, 0, 0, 0), Color(0, 0, 0, 1), 0.75, Tween.TRANS_LINEAR, Tween.EASE_IN)


		$FadeAnimator.start() # Start fade animation

		yield($FadeAnimator, "tween_completed") # Wait tween finish animation


	var sceneInstance = load(scene).instance() # Load scene and get instance

	if sceneInstance.has_method("_construct"): # If the scene has a construct method
		sceneInstance._construct(self) # Call the construct method of the new scene

	for key in params: # For each parameter
		sceneInstance.set(key, params[key]) # Set the parameter

	currentNode.call_deferred("free") # Free the old scene

	add_child(sceneInstance) # Add the new scene to the tree
	currentNode = get_node(sceneInstance.name) # Set the new scene as current node


	if fade:
		## Out fade
		# Set propriety of the fade transition node
		$FadeAnimator.interpolate_property(get_node("CanvasLayer/Overlay"), "color", Color(0, 0, 0, 1), Color(0, 0, 0, 0), 0.75, Tween.TRANS_LINEAR, Tween.EASE_IN)

		$FadeAnimator.start() # Start fade animation

		yield($FadeAnimator, "tween_completed") # Wait tween finish animation

	onChangingScene = false # Reset the scene changing flag

func _on_PauseMenu__set_pause_game(state):
	"""
		Callback to set the pause game flag
	"""

	currentNode.get_tree().paused = state # Set the pause game flag
