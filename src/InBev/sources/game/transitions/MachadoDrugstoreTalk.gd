extends Control

export(String) var callbackScenePath
export(Dictionary) var callbackSceneParams
export var textList = []

var currentTextList = 0
var changedView = false
var lastClickTime = 0

signal change_scene

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

func _runtime_talk():
	"""
		This function is called when the player clicks on the talk button.
		It will check if the player is allowed to talk to the NPC.
		If so, it will start the text animation.
	"""
	if(currentTextList > textList.size() - 1): # If the current text list is the last one, then we are done talking
		$AllScenery/PersonTalk.visible = false # Hide the talk button

		$GenericTimer.set_wait_time(0.5) # Wait 0.5 seconds before going to the next scene
		$GenericTimer.start() # Start the timer

		yield(get_node("GenericTimer"), "timeout") # Wait for the timer to finish
		$GenericTimer.stop()

		_go_next_scene() # Go to the next scene
	else:
		if textList[currentTextList].begins_with("self: "): # If the text begins with "self: " then we are talking to ourselves
			$AllScenery/SelfTalk/TalkLabel.text = textList[currentTextList].replace("self: ", "") # Replace the text with the text without "self: "
			$AllScenery/SelfTalk.visible = true # Show the talk button
			$AllScenery/PersonTalk.visible = false # Hide the talk button
			currentTextList += 1 # Go to the next text list
		else:
			$AllScenery/PersonTalk/TalkLabel.text = textList[currentTextList] # Set the text of the talk button
			$AllScenery/SelfTalk.visible = false # Hide the talk button
			$AllScenery/PersonTalk.visible = true # Show the talk button
			currentTextList += 1 # Go to the next text list

func _reset_call_and_init_text():
	"""
		Reset the call and init the text
	"""
	$AllScenery/PersonCall.visible = false # Hide the call button

	$GenericTimer.set_wait_time(0.5) # Set the timer to 0.5 seconds
	$GenericTimer.start() # Start the timer

	yield(get_node("GenericTimer"), "timeout") # Wait for the timer to finish
	$GenericTimer.stop() # Stop the timer

	_runtime_talk() # Start the runtime talk


func _on_NextTalk_pressed():
	if not changedView or (OS.get_system_time_msecs() - lastClickTime) < 1000: # If the user clicks the button too fast, ignore it
		return

	_runtime_talk() # Go to the next text

	lastClickTime = OS.get_system_time_msecs() # Update the last click time

func _on_ChangeView_pressed():
	if changedView: # If the view has changed, go back to the original view
		return

	# Change the view
	$CameraMoveTween.interpolate_method(self, "_change_all_scenery_position_x", $AllScenery.rect_position.x, 350, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN) # Position animation
	$CameraMoveTween.start()

