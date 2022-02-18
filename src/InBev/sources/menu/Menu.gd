extends Control

var gameScene

signal go_to_game

func _ready():
	connect("go_to_game", get_node("/root/MainScene"), "_change_scene_to")
	$AnimationPlayerMenu.play("ModulateVariation")

func _on_StartButton_pressed():
	$CenterContainer/StartButton.modulate = Color(0.95, 0.95, 0.95, 1)
	emit_signal("go_to_game", "res://scenes/Game.tscn")

