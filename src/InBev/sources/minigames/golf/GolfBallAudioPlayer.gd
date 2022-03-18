extends AudioStreamPlayer

const DEFAULT_XFX_PATH = "res://resources/sfx/golf/"

const HIT_XFX_LIST = ["golf_hit_ball_001.mp3", "golf_hit_ball_002.mp3", "golf_hit_ball_003.mp3"]
const HOLE_ENTER_XFX_LIST = ["Golf_Ball_In_Hole1.mp3", "Golf_Ball_In_Hole2.mp3"]
const BOUNCE_XFX_LIST = ["Golf_Putt_01.mp3", "Golf_Putt_02.mp3"]

func _random_xfx(soundList):
	"""
		Apply random sound effect from sound list.
	"""
	var random = RandomNumberGenerator.new() # Create a new random number generator
	random.randomize() # Randomize the random number generator

	var xfx = load(DEFAULT_XFX_PATH + soundList[random.randi_range(0, soundList.size() - 1)]) # Load the random sound effect from list
	xfx.loop = false # Set the sound effect one shot
	stream = xfx # Set the stream to the sound effect

func play_hit_sound():
	"""
		Play a random hit sound effect.
	"""
	_random_xfx(HIT_XFX_LIST) # Apply random hit sound effect

	set_volume_db(0) # Set the volume to default
	play() # Play the sound effect

func play_hole_enter_sound():
	"""
		Play a random hole enter sound effect.
	"""
	_random_xfx(HOLE_ENTER_XFX_LIST) # Apply random hit sound effect

	set_volume_db(0) # Set the volume to default
	play() # Play the sound effect

func play_wall_bounce_sound():
	"""
		Play a random wall bounce sound effect.
	"""
	_random_xfx(BOUNCE_XFX_LIST) # Apply random hit sound effect

	set_volume_db(0) # Set the volume to default
	play() # Play the sound effect

func play_turn_sound(): # Play the turn sound effect
	"""
		Play the change round sound effect.
	"""
	var xfx = load(DEFAULT_XFX_PATH + "your_turn.mp3") # Load the turn sound effect
	xfx.loop = false # Set the sound effect one shot
	stream = xfx # Set the stream to the sound effect

	set_volume_db(get_volume_db() - 10) # Set the volume to lower
	play() # Play the sound effect

func play_win_sound():
	"""
		Play the win sound effect.
	"""
	var xfx = load(DEFAULT_XFX_PATH + "level_completed.mp3") # Load the turn sound effect
	xfx.loop = false # Set the sound effect one shot
	stream = xfx # Set the stream to the sound effect

	set_volume_db(get_volume_db() - 10) # Set the volume to lower
	play() # Play the sound effect
