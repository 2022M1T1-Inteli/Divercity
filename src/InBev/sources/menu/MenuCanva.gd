extends Control

var menuOpacity = [1, 0]
var paused = false

signal _set_pause_game

static func toggle_bit(value):
	"""
		Toggle a bit value.
	"""
	return value ^ 1 # XOR with 1

func _ready():
	get_node("MenuLayer").modulate.a = 0 # Hide the menu by default
	get_node("MenuLayer").visible = false

func toggle_game_state():
	"""
		Toggle the game state between paused and unpaused.
	"""
	paused = not paused # toggle the bit

	emit_signal("_set_pause_game", paused) # Signal to the game that the game is paused or unpaused.

func toggle_menu_layer():
	"""
		Open the menu layer for user.
	"""
	menuOpacity.invert() # invert the opacity array

	if menuOpacity[0] == 0:
		get_node("MenuLayer").visible = true

	var tween = Tween.new() # Create tween
	add_child(tween) # Add tween to node

	tween.interpolate_property(get_node("MenuLayer"), "modulate:a", menuOpacity[0], menuOpacity[1],  0.2, Tween.TRANS_LINEAR, Tween.EASE_IN) # Modulation animation
	tween.interpolate_property(get_node("ToggleMenuButton"), "modulate:a", toggle_bit(menuOpacity[0]), toggle_bit(menuOpacity[1]),  0.1, Tween.TRANS_LINEAR, Tween.EASE_IN) # Modulation animation
	tween.start() # Start fade animation

	yield(tween, "tween_all_completed") # Wait tween animation complete

	if menuOpacity[0] == 1:
		get_node("MenuLayer").visible = false

	tween.call_deferred("free") # Free tween animator

func _on_ToggleMenuButton_pressed():
	if menuOpacity[0] == 1: # if menu is closed
		toggle_menu_layer() # Toggle menu layer
		toggle_game_state() # Toggle game state
		get_node("MenuLayer").call("_update") # Update menu layer

func _on_CloseButton_pressed():
	if menuOpacity[0] == 0: # if menu is opened
		toggle_menu_layer() # Toggle menu layer
		toggle_game_state() # Toggle game state
		get_node("MenuLayer").call("_update") # Update menu layer
