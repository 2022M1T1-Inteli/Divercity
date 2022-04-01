extends Node

enum QuestionType { TEXT, IMAGE, VIDEO, AUDIO }

export (Resource) var dbQuiz
export(Color) var colorRight
export(Color) var colorWrong

var buttons := []
var index := 0

onready var questionText = $QuestionInfo/TxtQuestion

func _ready() -> void:
	for _button in ($QuestionHolder.get_children()):   
		buttons.append(_button)
	
	loadQuiz()


func loadQuiz() -> void:
	if index >= dbQuiz.db.size():			#Condicional de verificação caso ainda tenha perguntasa no banco de dados
		print("Acabram as perguntas")
		return
	
	questionText.text = str(dbQuiz.db[index].questionInfo)		#Muda o texto da pergunta
	
	for i in buttons.size():									#Muda o texto dentro dos botes
		buttons[i].text = str(dbQuiz.db[index].options[i])
		buttons[i].connect("pressed", self, "buttonsAnswer", [buttons[i]])
	
	match dbQuiz.db[index].type:							# Ainda não usado em nosso contexto, mas possibilita
		QuestionType.TEXT:									#o uso de imagens, videos e sons nas perguntas
			$QuestionInfo/ImageHolder.hide()
			
#		QuestionType.IMAGE:
#			$question_info/image_holder.show()
#			question_image.texture = bd_quiz.bd[index].question_image
#
#		QuestionType.VIDEO:
#			$question_info/image_holder.show()
#			question_video.stream = bd_quiz.bd[index].question_video
#			question_video.play()
#
#		QuestionType.AUDIO:
#			$question_info/image_holder.show()
#			question_image.texture = load("res://sprites/sound.png")
#			question_audio.stream = bd_quiz.bd[index].question_audio
#			question_audio.play()


func buttonsAnswer(button) -> void:					#Verifica resposta e muda o comportamento dos botoes
	if dbQuiz.db[index].correct == button.text:
		button.modulate = colorRight
	else:
		button.modulate = colorWrong
		
	yield(get_tree().create_timer(1), "timeout")
	for bt in buttons:
		bt.modulate = Color.white
		bt.disconnect("pressed", self, "buttonAnswer")
		
	index += 1
	loadQuiz()
