extends Node

var menu = load("res://scenes/Menu.tscn")
var game = load("res://scenes/Game.tscn")

func _ready():
	add_child(menu.instance())

func _on_change_to_game():
	$FadeAnimator.interpolate_property(get_node("CanvasLayer/Overlay"), "color", Color(0, 0, 0, 0), Color(0, 0, 0, 1), 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$FadeAnimator.start()
	yield($FadeAnimator, "tween_completed")
	get_node("Menu").get_tree().change_scene_to(game)
