extends Control

export(String) var callbackScenePath
export(Dictionary) var callbackSceneParams
export var textList = []

var currentTextList = 0
var changedView = false
var lastClickTime = 0

signal change_scene

func _construct(mainNode):
	connect("change_scene", mainNode, "_change_scene_to") # Connect callback for local signal

func _on_Tween_tween_all_completed():
	_reset_call_and_init_text()
	changedView = true

func _go_next_scene():
	emit_signal("change_scene", callbackScenePath, true, callbackSceneParams) # Emit the change scene signal to the game scene

func _change_all_scenery_position_x(positionX):
	$AllScenery.rect_position.x = positionX

func _runtime_talk():
	if(currentTextList > textList.size() - 1):
		$AllScenery/PersonTalk.visible = false

		$GenericTimer.set_wait_time(0.5)
		$GenericTimer.start()

		yield(get_node("GenericTimer"), "timeout")
		$GenericTimer.stop()

		_go_next_scene()
	else:
		if textList[currentTextList].begins_with("self: "):
			$AllScenery/SelfTalk/TalkLabel.text = textList[currentTextList].replace("self: ", "")
			$AllScenery/SelfTalk.visible = true
			$AllScenery/PersonTalk.visible = false
			currentTextList += 1
		else:
			$AllScenery/PersonTalk/TalkLabel.text = textList[currentTextList]
			$AllScenery/SelfTalk.visible = false
			$AllScenery/PersonTalk.visible = true
			currentTextList += 1

func _reset_call_and_init_text():
	$AllScenery/PersonCall.visible = false

	$GenericTimer.set_wait_time(0.5)
	$GenericTimer.start()

	yield(get_node("GenericTimer"), "timeout")
	$GenericTimer.stop()

	_runtime_talk()


func _on_NextTalk_pressed():
	if not changedView or (OS.get_system_time_msecs() - lastClickTime) < 1000:
		return

	_runtime_talk()

	lastClickTime = OS.get_system_time_msecs()

func _on_ChangeView_pressed():
	if changedView:
		return

	$CameraMoveTween.interpolate_method(self, "_change_all_scenery_position_x", $AllScenery.rect_position.x, 350, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN) # Position animation
	$CameraMoveTween.start()

