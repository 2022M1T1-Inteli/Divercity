extends AudioStreamPlayer

const DEFAULT_XFX_PATH = "res://resources/sfx/pipe/"

const WIN_MINIGAME_XFX_LIST = ["MinigameWin.wav"]
const LOSE_MINIGAME_XFX_LIST = ["MinigameLose.mp3"]


func _random_xfx(soundList):
	"""
		Apply random sound effect from sound list.
	"""
	var random = RandomNumberGenerator.new() # Create a new random number generator
	random.randomize() # Randomize the random number generator

	var xfx = load(DEFAULT_XFX_PATH + soundList[random.randi_range(0, soundList.size() - 1)]) # Load the random sound effect from list
	xfx.loop = false # Set the sound effect one shot
	stream = xfx # Set the stream to the sound effect

func play_win_minigame_sound():
	"""
		Play a random win minigame sound effect.
	"""
	_random_xfx(WIN_MINIGAME_XFX_LIST) # Apply random hit sound effect

	set_volume_db(0) # Set the volume to default
	play() # Play the sound effect

func play_lose_minigame_sound():
	"""
		Play a random lose minigame sound effect.
	"""
	_random_xfx(LOSE_MINIGAME_XFX_LIST) # Apply random hit sound effect

	set_volume_db(0) # Set the volume to default
	play() # Play the sound effect

