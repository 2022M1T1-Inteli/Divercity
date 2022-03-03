extends AudioStreamPlayer

const DEFAULT_XFX_PATH = "res://resources/sfx/golf/"

const HIT_BALL_XFX_LIST = ["golf_hit_ball_001.mp3", "golf_hit_ball_002.mp3", "golf_hit_ball_003.mp3"]
const HOLE_ENTER_XFX_LIST = ["Golf_Ball_In_Hole1.mp3", "Golf_Ball_In_Hole2.mp3"]

func _random_xfx(soundList): # Apply random hit sound effect
	var random = RandomNumberGenerator.new() # Create a new random number generator
	random.randomize() # Randomize the random number generator
	var xfx = load(DEFAULT_XFX_PATH + soundList[random.randi_range(0, soundList.size() - 1)]) # Load the random sound effect from list
	xfx.loop = false # Set the sound effect one shot
	stream = xfx # Set the stream to the sound effect

func play_hit_sound(): # Play the hit sound effect
	_random_xfx(HIT_BALL_XFX_LIST) # Apply random hit sound effect
	play() # Play the sound effect

func play_hole_enter_sound(): # Play the hit sound effect
	_random_xfx(HOLE_ENTER_XFX_LIST) # Apply random hit sound effect
	play() # Play the sound effect
