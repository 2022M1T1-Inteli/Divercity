extends Control

export(String) var callbackScenePath
export(Dictionary) var callbackSceneParams

signal change_scene

func _construct(mainNode):
	"""
		Node constructors
	"""
	connect("change_scene", mainNode, "_change_scene_to") # Connect callback for local signal

func _go_next_scene():
	"""
		Go to next scene
	"""
	emit_signal("change_scene", callbackScenePath, true, callbackSceneParams) # Emit the change scene signal to the game scene

func _on_Continue_pressed():
	_go_next_scene() # Go to next scene
