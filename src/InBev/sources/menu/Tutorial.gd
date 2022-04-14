extends Control

signal change_scene # Create local signal for change to game scene

export(String) var callbackScenePath = "res://scenes/menu/Menu.tscn"
export(Dictionary) var callbackSceneParams = {}

var current = 0

func _ready():
	next_tutorial()

func _construct(mainNode):
	"""
		Node constructor
	"""
	connect("change_scene", mainNode, "_change_scene_to") # Connect callback for local signal

func next_tutorial():
	current += 1
	if current >= 4:
		emit_signal("change_scene", callbackScenePath, false, callbackSceneParams) # Emit the change scene signal to the game scene
	for i in range (1, 4):
		get_node("Tutorial" + str(i)).visible = true if current == i else false

func _on_TouchScreenButton_pressed():
	next_tutorial()
