extends Control

export(String) var correctAnswer
export(Array) var otherAnswers
export(String) var quizzQuestion

export(String) var callbackScenePath
export(Dictionary) var callbackSceneParams

signal change_scene # Create local signal for change to game scene

var correctButttonPath = null
var lastClickTime = 0

func _construct(mainNode):
	connect("change_scene", mainNode, "_change_scene_to") # Connect callback for local signal

func _ready():
	$QuestionLabel.text = quizzQuestion

	randomize()

	var nodesAnswers = ["AnswersLabel/Answers1Label", "AnswersLabel/Answers2Label", "AnswersLabel/Answers3Label"]

	nodesAnswers.shuffle()

	var copyOtherAnswers = otherAnswers
	print(otherAnswers)
	correctButttonPath = nodesAnswers.pop_front()
	var i = 0
	for nodePath in nodesAnswers:
		get_node(nodePath).text = copyOtherAnswers[i]["question"]
		i += 1

	get_node(correctButttonPath).text = correctAnswer


func correct_answer():
	emit_signal("change_scene", callbackScenePath, true, callbackSceneParams) # Emit the change scene signal to the game scene

func wrong_answer(question):
	var response = ""
	print(otherAnswers)
	for questionMain in otherAnswers:
		print(question, questionMain)
		if question == questionMain["question"]:
			response = questionMain["justification"]

	$Justification/ResponseLabel.text = response
	$Justification.visible = true

func check_answer(answer, question):
	if correctButttonPath.rfind(answer) != -1:
		correct_answer()
	else:
		wrong_answer(question)

func _on_Answer3Button_pressed():
	if $Justification.visible or (OS.get_system_time_msecs() - lastClickTime) < 1000:
		return
	check_answer(3, get_node("AnswersLabel/Answers3Label").text)

func _on_Answer2Button_pressed():
	if $Justification.visible or (OS.get_system_time_msecs() - lastClickTime) < 1000:
		return
	check_answer(2, get_node("AnswersLabel/Answers2Label").text)

func _on_Answer1Button_pressed():
	if $Justification.visible or (OS.get_system_time_msecs() - lastClickTime) < 1000:
		return
	check_answer(1, get_node("AnswersLabel/Answers1Label").text)


func _on_SkipJustificationButton_pressed():
	if not $Justification.visible:
		return
	$Justification.visible = false
	lastClickTime = OS.get_system_time_msecs()
