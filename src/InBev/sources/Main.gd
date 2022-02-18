extends Node

var menu = load("res://scenes/Menu.tscn")

func _ready():
	add_child(menu.instance())

func _change_scene_to(scene):
	$FadeAnimator.interpolate_property(get_node("CanvasLayer/Overlay"), "color", Color(0, 0, 0, 0), Color(0, 0, 0, 1), 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$FadeAnimator.start()
	yield($FadeAnimator, "tween_completed")
	get_node("Menu").get_tree().change_scene_to(load(scene))
