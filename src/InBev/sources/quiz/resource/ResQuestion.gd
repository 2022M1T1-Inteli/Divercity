extends Resource

class_name QuizQuestion

enum QuestionType { TEXT, IMAGE, VIDEO, AUDIO }

export(String) var questionInfo
export(QuestionType) var type
export(Texture) var questionImage
#export(AudioStream) var question_audio
#export(VideoStream) var question_video
export(Array, String) var options
export(String) var correct


