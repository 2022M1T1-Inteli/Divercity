extends Control

export(Texture) var backgroundTexture

export(String) var callbackScenePath
export(Dictionary) var callbackSceneParams

func _construct(mainNode):
	connect("change_scene", mainNode, "_change_scene_to") # Connect callback for local signal

func _ready():
	$BackgroundTexture.texture = backgroundTexture # Set background texture

func _on_ContinueButton_pressed():
	emit_signal("change_scene", callbackScenePath, true, callbackSceneParams) # Emit signal to change scene