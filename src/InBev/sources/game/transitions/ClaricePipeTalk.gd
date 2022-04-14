extends "bases/Dialog.gd"

export(String) var callbackScenePath
export(Dictionary) var callbackSceneParams

signal change_scene

func _go_next_scene():
	"""
		Go to next scene
	"""
	emit_signal("change_scene", callbackScenePath, true, callbackSceneParams) # Emit the change scene signal to the game scene

func _construct(mainNode):
	"""
		Node constructor
	"""
	connect("change_scene", mainNode, "_change_scene_to") # Connect callback for local signal

func _ready():
	nextSceneCallback = "_go_next_scene" # Set the next scene callback
	selfNode = get_node("SelfTalk") # Get the self talk node
	personNode = get_node("PersonTalk") # Get the person talk node
	personName = "Clarice"

	$GenericTimer.set_wait_time(0.5) # Set the timer to 0.5 seconds
	$GenericTimer.start() # Start the timer

	yield(get_node("GenericTimer"), "timeout") # Wait for the timer to finish
	$GenericTimer.stop() # Stop the timer

	_runtime_talk() # Start the runtime talk


func _on_NextTalk_pressed():
	if not can_jump_dialog(): # Check timer to jump dialog
		return

	_runtime_talk() # Call the runtime talk function

func _on_ReturnTalk_pressed():
	_return_talk()