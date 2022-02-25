extends Node

onready var currentNode = get_node("BaseReplaceNode") # get current template node

func _ready():
	_change_scene_to("res://scenes/Menu/Menu.tscn", false) # Add the menu scene to the scene stack

func _change_scene_to(scene, fade = true): # Callback to change scene from childs
	if fade: # If need fade
		## In fade

		# Set propriety of the fade transition node
		$FadeAnimator.interpolate_property(get_node("CanvasLayer/Overlay"), "color", Color(0, 0, 0, 0), Color(0, 0, 0, 1), 0.75, Tween.TRANS_LINEAR, Tween.EASE_IN)


		$FadeAnimator.start() # Start fade animation

		yield($FadeAnimator, "tween_completed") # Wait tween finish animation


	var sceneInstance = load(scene).instance() # Load scene and get instance

	if sceneInstance.has_method("_construct"): # If the scene has a construct method
		sceneInstance._construct(self) # Call the construct method of the new scene

	currentNode.call_deferred("free") # Free the old scene

	add_child(sceneInstance) # Add the new scene to the tree
	currentNode = get_node(sceneInstance.name) # Set the new scene as current node

	if fade:
		## Out fade
		# Set propriety of the fade transition node
		$FadeAnimator.interpolate_property(get_node("CanvasLayer/Overlay"), "color", Color(0, 0, 0, 1), Color(0, 0, 0, 0), 0.75, Tween.TRANS_LINEAR, Tween.EASE_IN)

		$FadeAnimator.start() # Start fade animation

		yield($FadeAnimator, "tween_completed") # Wait tween finish animation
