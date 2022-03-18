extends Control

export(String) var callbackScenePath
export(Dictionary) var callbackSceneParams
export var textList = []

signal change_scene

var currentTextList = 0
var lastClickTime = 0

func _go_next_scene():
	emit_signal("change_scene", callbackScenePath, true, callbackSceneParams) # Emit the change scene signal to the game scene

func _construct(mainNode):
	connect("change_scene", mainNode, "_change_scene_to") # Connect callback for local signal

func _ready():
	$GenericTimer.set_wait_time(0.5)
	$GenericTimer.start()

	yield(get_node("GenericTimer"), "timeout")
	$GenericTimer.stop()

	_runtime_talk()

func _runtime_talk():
	if(currentTextList > textList.size() - 1):
		$PersonTalk.visible = false

		$GenericTimer.set_wait_time(0.5)
		$GenericTimer.start()

		yield(get_node("GenericTimer"), "timeout")
		$GenericTimer.stop()

		_go_next_scene()
	else:
		if textList[currentTextList].begins_with("self: "):
			$SelfTalk/TalkLabel.text = textList[currentTextList].replace("self: ", "")
			$SelfTalk.visible = true
			$PersonTalk.visible = false
			currentTextList += 1
		else:
			$PersonTalk/TalkLabel.text = textList[currentTextList]
			$SelfTalk.visible = false
			$PersonTalk.visible = true
			currentTextList += 1


func _on_NextTalk_pressed():
	if (OS.get_system_time_msecs() - lastClickTime) < 1000:
		return

	_runtime_talk()

	lastClickTime = OS.get_system_time_msecs()
