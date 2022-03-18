extends Control

export(String) var backgroundTexture

export(String) var playCallbackScenePath
export(Dictionary) var playCallbackSceneParams

export(String) var surrenderCallbackScenePath
export(Dictionary) var surrenderCallbackSceneParams

export(String) var minigameName = ""

signal change_scene

func _construct(mainNode):
	connect("change_scene", mainNode, "_change_scene_to") # Connect callback for local signal

func _ready():
	$BackgroundTexture.texture = load(backgroundTexture)
	$MinigameNameLabel.text = minigameName

func _on_PlayButton_pressed():
	emit_signal("change_scene", playCallbackScenePath, true, playCallbackSceneParams) # Emit signal to change scene

func _on_SurrenderButton_pressed():
	emit_signal("change_scene", surrenderCallbackScenePath, true, surrenderCallbackSceneParams)# Emit signal to change scene
