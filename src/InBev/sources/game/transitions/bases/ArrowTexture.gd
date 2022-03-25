extends TextureRect

var currentBlinkState = [1, 0.5]

func _ready():
	create_tween_instance()
	runtime_tween_animation()

func create_tween_instance():
	"""
		Create tween for base arrow animations
	"""

	var tween = Tween.new()
	tween.name = "ArrowTextureTween"
	add_child(tween)
	tween.connect("tween_completed", self, "reset_tween_animation")

func runtime_tween_animation():
	"""
		Animate blink effect in arrow
	"""
	get_node("ArrowTextureTween").interpolate_method(self, "change_modulation_A", currentBlinkState[0], currentBlinkState[1], 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN) # Blink animation
	get_node("ArrowTextureTween").start() # Start animation

func reset_tween_animation(_object, _key):
	currentBlinkState.invert()
	runtime_tween_animation()

func change_modulation_A(value):
	"""
		Change modulation tranparence of self
	"""
	self.modulate.a = value
