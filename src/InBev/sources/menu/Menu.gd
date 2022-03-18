extends Control

signal change_scene # Create local signal for change to game scene

export(String) var callbackScenePath = "res://scenes/game/transitions/StarWarsText.tscn"
export(Dictionary) var callbackSceneParams = {
	"callbackScenePath": "res://scenes/game/Map.tscn"
}

func _construct(mainNode):
	connect("change_scene", mainNode, "_change_scene_to") # Connect callback for local signal

func _on_StartButton_pressed(): # Callback on click start button
	$CarAnimator.interpolate_method(self, "_change_car_position_x", $CarTexture.rect_position.x,  0, 0.8, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$CarAnimator.start()

	emit_signal("change_scene", callbackScenePath, true, callbackSceneParams) # Emit the change scene signal to the game scene

func _change_car_position_x(positionX):
	$CarTexture.rect_position.x = positionX

func _on_ExitButton_pressed(): # Callback on click start button
	get_tree().quit() # Quit game
