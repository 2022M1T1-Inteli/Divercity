extends Control

export(String) var callbackScenePath
export(Dictionary) var callbackSceneParams
export var textList = []

signal change_scene

var currentTextList = 0
var lastClickTime = 0

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
	$GenericTimer.set_wait_time(0.5) # Set the timer to 0.5 seconds
	$GenericTimer.start() # Start the timer

	yield(get_node("GenericTimer"), "timeout") # Wait for the timer to finish
	$GenericTimer.stop() # Stop the timer

	_runtime_talk() # Start the runtime talk

func _runtime_talk():
	"""
		This function is called when the timer times out.
		It will then call the next text in the list.
	"""
	if(currentTextList > textList.size() - 1): # If the current text list is greater than the size of the text list
		$PersonTalk.visible = false # Hide the person talk

		$GenericTimer.set_wait_time(0.5) # Set the timer to 0.5 seconds
		$GenericTimer.start() # Start the timer

		yield(get_node("GenericTimer"), "timeout") # Wait for the timer to finish
		$GenericTimer.stop() # Stop the timer

		_go_next_scene() # Go to the next scene
	else:
		if textList[currentTextList].begins_with("self: "): # If the text starts with "self: "
			$SelfTalk/TalkLabel.text = textList[currentTextList].replace("self: ", "") # Set the text
			$SelfTalk.visible = true # Show the self talk node
			$PersonTalk.visible = false # Hide the person talk node
			currentTextList += 1 # Increment the current text list
		else:
			$PersonTalk/TalkLabel.text = textList[currentTextList] # Set the text
			$SelfTalk.visible = false # Hide the self talk
			$PersonTalk.visible = true # Show the person talk
			currentTextList += 1 # Increment the current text list


func _on_NextTalk_pressed():
	if (OS.get_system_time_msecs() - lastClickTime) < 1000: # If the time since the last click is less than 1 second
		return

	_runtime_talk() # Call the runtime talk function

	lastClickTime = OS.get_system_time_msecs() # Set the last click time to the current time
