extends TouchScreenButton

export(String) var callbackScenePath
export(Dictionary) var callbackSceneParams
export var isEnable = false setget set_status
export var indentifier = 0

func set_status(state):
	"""
		Set state of grayscale shaders params.
	"""
	visible = state # Set visible state
	isEnable = state

func get_status():
	"""
		Get state of grayscale shaders params.
	"""
	return visible # Get visible.

func _ready():
	visible = isEnable

	connect("pressed", self, "_on_pressed_input") # Connect the _on_gui_input method to the gui_input signal.

func _on_pressed_input():
	if not isEnable:
		return

	get_parent().get_parent().emit_signal("change_scene", callbackScenePath, true, callbackSceneParams) # Emit the change_scene signal.
