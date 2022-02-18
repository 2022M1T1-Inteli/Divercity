extends Control

# Create local signal for change to game scene
signal go_to_game

func _ready():
	# Connect callback for local signal
	connect("go_to_game", get_node("/root/MainScene"), "_change_scene_to")

	# Init main moon light animation
	$AnimationPlayerMenu.play("ModulateVariation")

func _on_StartButton_pressed(): # Callback on click start button
	# Change button light for response click
	$CenterContainer/StartButton.modulate = Color(0.95, 0.95, 0.95, 1)

	# Emit signal to change scene
	emit_signal("go_to_game", "res://scenes/Game/Game.tscn")

