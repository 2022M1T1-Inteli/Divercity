extends Control

export var textList = []

var currentTextList = 0
var lastClickTime = 0

const TIME_BETWEEN_CLICKS = 550 # ms

var personNode = null
var selfNode = null
var nextSceneCallback = null

func _runtime_talk():
	"""
		This function is called when the timer times out.
		It will then call the next text in the list.
	"""
	reset_touch_timer()

	if(currentTextList > textList.size() - 1): # If the current text list is greater than the size of the text list
		personNode.visible = false # Hide the person talk

		$GenericTimer.set_wait_time(0.5) # Set the timer to 0.5 seconds
		$GenericTimer.start() # Start the timer

		yield(get_node("GenericTimer"), "timeout") # Wait for the timer to finish
		$GenericTimer.stop() # Stop the timer

		call(nextSceneCallback) # Call the next scene
	else:
		if textList[currentTextList].begins_with("self: "): # If the text starts with "self: "
			selfNode.get_node("TalkLabel").text = textList[currentTextList].replace("self: ", "") # Set the text
			selfNode.visible = true # Show the self talk node
			personNode.visible = false # Hide the person talk node
			currentTextList += 1 # Increment the current text list
		else:
			personNode.get_node("TalkLabel").text = textList[currentTextList] # Set the text
			selfNode.visible = false # Hide the self talk
			personNode.visible = true # Show the person talk
			currentTextList += 1 # Increment the current text list

func reset_touch_timer():
	"""
		This function resets the touch timer.
	"""
	lastClickTime = OS.get_system_time_msecs() # Set the last click time to the current time

func can_jump_dialog():
	"""
		This function checks if the player can jump to the next dialog.
	"""
	return (OS.get_system_time_msecs() - lastClickTime) > TIME_BETWEEN_CLICKS # If the time between clicks is less than the threshold
