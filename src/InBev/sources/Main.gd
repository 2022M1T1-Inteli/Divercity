extends Node

# Load the menu node
var menu = load("res://scenes/Menu/Menu.tscn")

func _ready():
	# Add the menu scene to the scene stack
	add_child(menu.instance())

func _change_scene_to(scene): # Callback to change scene from childs
	# Set propriety of the fade transition node
	$FadeAnimator.interpolate_property(get_node("CanvasLayer/Overlay"), "color", Color(0, 0, 0, 0), Color(0, 0, 0, 1), 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)

	# Start fade animation
	$FadeAnimator.start()

	# Wait tween finish animation
	yield($FadeAnimator, "tween_completed")

	# Change tree scene for the new scene
	get_node("Menu").get_tree().change_scene_to(load(scene))
