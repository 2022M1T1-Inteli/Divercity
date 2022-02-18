extends Control

var gameScene

signal go_to_game

func _ready():
	connect("go_to_game", get_node("/root/MainScene"), "_on_change_to_game")
	$AnimationPlayerMenu.play("ModulateVariation")

func _on_StartButton_pressed():
	$StartButton.modulate = Color(0.95, 0.95, 0.95, 1)
	emit_signal("go_to_game")

