extends Node


export(String) var callbackScenePath
export(Dictionary) var callbackSceneParams
export var loadMap = 1

signal change_scene # Create local signal for change to game scene

func _construct(mainNode):
	"""
		Node constructor
	"""
	connect("change_scene", mainNode, "_change_scene_to") # Connect callback for local signal

func _ready():
	get_node("Table").call("load_map", loadMap) # Load map in table

func _on_ContinueButton_pressed():
	emit_signal("change_scene", callbackScenePath, true, callbackSceneParams) # Emit the change scene signal to the game scene
