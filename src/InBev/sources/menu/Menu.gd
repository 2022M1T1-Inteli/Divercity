extends Control

# Create local signal for change to game scene
signal go_to_game

func _construct(mainNode):
	connect("go_to_game", mainNode, "_change_scene_to") # Connect callback for local signal

func _on_StartButton_pressed(): # Callback on click start button
	$CarAnimator.interpolate_method(self, "_change_car_position_x", $CarTexture.rect_position.x,  0, 0.8, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$CarAnimator.start()

	emit_signal("go_to_game", "res://scenes/game/Map.tscn") # Emit signal to change scene

func _change_car_position_x(positionX):
	$CarTexture.rect_position.x = positionX

func _on_ExitButton_pressed(): # Callback on click start button
	get_tree().quit() # Quit game
