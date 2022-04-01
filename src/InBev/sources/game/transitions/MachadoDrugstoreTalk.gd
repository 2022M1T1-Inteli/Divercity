extends "bases/Dialog.gd"

export(String) var callbackScenePath
export(Dictionary) var callbackSceneParams

var changedView = false

signal change_scene

func _ready():
	nextSceneCallback = "_go_next_scene" # Set the next scene callback
	selfNode = get_node("AllScenery/SelfTalk") # Get the self talk node
	personNode = get_node("AllScenery/PersonTalk") # Get the person talk node

func _construct(mainNode):
	"""
		Node constructors
	"""
	connect("change_scene", mainNode, "_change_scene_to") # Connect callback for local signal

func _on_Tween_tween_all_completed():
	_reset_call_and_init_text()
	changedView = true

func _go_next_scene():
	"""
		Go to next scene
	"""
	emit_signal("change_scene", callbackScenePath, true, callbackSceneParams) # Emit the change scene signal to the game scene

func _change_all_scenery_position_x(positionX):
	"""
		Change all scenery position x
	"""
	$AllScenery.rect_position.x = positionX

func _reset_call_and_init_text():
	"""
		Reset the call and init the text
	"""
	$AllScenery/PersonCall.visible = false # Hide the call button

	_runtime_talk() # Start the runtime talk


func _on_NextTalk_pressed():
	if not changedView and not can_jump_dialog(): # If the user clicks the button too fast, ignore it
		return

	_runtime_talk() # Go to the next text

func _on_ChangeView_pressed():
	if changedView: # If the view has changed, go back to the original view
		return

	# Change the view
	$CameraMoveTween.interpolate_method(self, "_change_all_scenery_position_x", $AllScenery.rect_position.x, 350, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN) # Position animation
	$CameraMoveTween.start() # Start animation

