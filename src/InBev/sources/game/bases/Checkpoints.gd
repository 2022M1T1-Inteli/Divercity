extends TouchScreenButton

export(String) var callbackScenePath
export(Dictionary) var callbackSceneParams
export var isEnable = false setget set_status
export var indentifier = 0

onready var grayscaleShaderPixelPerfect = preload("res://sources/common/shaders/GrayscalePixelPerfect.gdshader")

func set_status(state):
	"""
		Set state of grayscale shaders params.
	"""
	material.set_shader_param("grayscale", not state) # Set the shader parameter to true.
	isEnable = state

func get_status():
	"""
		Get state of grayscale shaders params.
	"""
	return not material.get_shader_param("grayscale") # Get the shader parameter.

func _ready():
	material = ShaderMaterial.new() # Create a new shader material.
	material.shader = grayscaleShaderPixelPerfect # Set the shader to the grayscale shader.
	material.set_shader_param("grayscale", not isEnable) # Set the grayscale parameter to false.

	connect("pressed", self, "_on_pressed_input") # Connect the _on_gui_input method to the gui_input signal.

func _on_pressed_input():
	if not isEnable:
		return

	get_parent().get_parent().emit_signal("change_scene", callbackScenePath, true, callbackSceneParams) # Emit the change_scene signal.
