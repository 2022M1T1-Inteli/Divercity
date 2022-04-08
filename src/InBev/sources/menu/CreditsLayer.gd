extends Control

func show_self():
	"""
		Show the control node.
	"""
	modulate.a = 0 # Reset the modulator
	visible = true # Show credits

	get_node("Tween").interpolate_property(self, "modulate:a", 0, 1,  0.2, Tween.TRANS_LINEAR, Tween.EASE_IN) # Modulation animation
	get_node("Tween").start() # Start animation

	yield(get_node("Tween"), "tween_all_completed") # Wait tween animation complete

func _on_CloseButton_pressed():
	get_node("Tween").interpolate_property(self, "modulate:a", 1, 0,  0.25, Tween.TRANS_LINEAR, Tween.EASE_IN) # Modulation animation
	get_node("Tween").start() # Start animation

	yield(get_node("Tween"), "tween_all_completed") # Wait tween animation complete

	visible = false # Hide credits
