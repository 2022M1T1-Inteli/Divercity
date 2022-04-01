extends Control

signal change_scene # Create local signal for change to game scene

export(String) var callbackScenePath
export(Dictionary) var callbackSceneParams

var changingScene = false
var tempPositionY = 0
var additionalPositionY = 0
var rapid = false

func _construct(mainNode):
	"""
		Node constructor
	"""
	connect("change_scene", mainNode, "_change_scene_to") # Connect callback for local signal

func _ready():
	# Set up scene text animation
	$TextTween.interpolate_method(self, "save_temp_position_y", $MainTextLabel.rect_position.y, -1800, 25, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	$TextTween.start()

func save_temp_position_y(positionY):
	tempPositionY = positionY

func _set_main_text_position_y(positionY):
	"""
		Set main text position y ( scrolling )
	"""
	$MainTextLabel.rect_position.y = positionY # Set positiony

func _process(delta):
	if $MainTextLabel.rect_position.y <= -1800 && not changingScene:
		changingScene = true
		emit_signal("change_scene", callbackScenePath, true, callbackSceneParams) # Emit the change scene signal to the game scene
	elif(rapid):
		additionalPositionY += -6

	_set_main_text_position_y(tempPositionY + additionalPositionY)


func _on_TextTween_tween_all_completed():
	emit_signal("change_scene", callbackScenePath, true, callbackSceneParams) # Emit the change scene signal to the game scene


func _on_Button_button_down():
	rapid = true

func _on_Button_button_up():
	rapid = false
