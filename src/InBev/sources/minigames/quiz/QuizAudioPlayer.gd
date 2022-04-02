extends AudioStreamPlayer

const DEFAULT_XFX_PATH = "res://resources/sfx/quiz/"

const WIN_QUIZ_XFX_LIST = ["QuizWin.wav"]
const LOSE_QUIZ_XFX_LIST = ["QuizLose.wav"]



func _random_xfx(soundList):
	"""
		Apply random sound effect from sound list.
	"""
	var random = RandomNumberGenerator.new() # Create a new random number generator
	random.randomize() # Randomize the random number generator

	var xfx = load(DEFAULT_XFX_PATH + soundList[random.randi_range(0, soundList.size() - 1)]) # Load the random sound effect from list
#	xfx.loop = false # Set the sound effect one shot
	stream = xfx # Set the stream to the sound effect

func play_win_quiz_sound():
	"""
		Play a random win quiz sound effect.
	"""
	_random_xfx(WIN_QUIZ_XFX_LIST) # Apply random hit sound effect

	set_volume_db(0) # Set the volume to default
	play() # Play the sound effect

func play_lose_quiz_sound():
	"""
		Play a random fala sound effect.
	"""
	_random_xfx(LOSE_QUIZ_XFX_LIST) # Apply random hit sound effect

	set_volume_db(0) # Set the volume to default
	play() # Play the sound effect




#func play_turn_sound(): # Play the turn sound effect
#	"""
#		Play the change round sound effect.
#	"""
#	var xfx = load(DEFAULT_XFX_PATH + "your_turn.mp3") # Load the turn sound effect
#	xfx.loop = false # Set the sound effect one shot
#	stream = xfx # Set the stream to the sound effect
#
#	set_volume_db(get_volume_db() - 10) # Set the volume to lower
#	play() # Play the sound effect
#
#func play_win_sound():
#	"""
#		Play the win sound effect.
#	"""
#	var xfx = load(DEFAULT_XFX_PATH + "level_completed.mp3") # Load the turn sound effect
#	xfx.loop = false # Set the sound effect one shot
#	stream = xfx # Set the stream to the sound effect
#
#	set_volume_db(get_volume_db() - 10) # Set the volume to lower
#	play() # Play the sound effect
