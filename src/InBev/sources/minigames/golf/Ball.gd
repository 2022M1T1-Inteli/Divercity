extends KinematicBody2D

export var deceleration = 100
export var maxSpeed = 600
export var max_reach = 250

var isHolding = false
var startPosition = Vector2.ZERO
var drop_direction = Vector2.ZERO

var velocity = Vector2(0, 0)
var speed = 0

const DEFAULT_XFX_PATH = "res://resources/sfx/golf/"
const HIT_BALL_XFX_LIST = ["golf_hit_ball_001.mp3", "golf_hit_ball_002.mp3", "golf_hit_ball_003.mp3"]

func calculate_speed(distance): # Calcule speed of all in base of distance of start and drop click
	distance = clamp(distance, 0, max_reach) # Clamp distance to max reach
	distance = range_lerp(distance, 0, max_reach, 0, maxSpeed) # Lerp distance to speed
	return distance # Return speed

func _input(event):
	if velocity.length() > 0: # Ignore if is moving
		return

	if event is InputEventScreenTouch: # If touch event
		if event.pressed: # If touch down
			startPosition = get_global_mouse_position() # Get start position
			isHolding = true # Set is holding

		if not event.pressed: # If touch up
			$GolfBallAudioPlayer.play_hit_sound() # Play shot sound

			drop_direction = get_global_mouse_position().direction_to(global_position) # Get direction of drop from start position and current position
			isHolding = false # Set is not holding

			velocity = Vector2(speed, 0).rotated(drop_direction.angle()) # Set velocity

func _draw():
	if isHolding: # If is holding
		draw_line(global_position - position, get_global_mouse_position() - position, Color.black, 5, true) # Draw line from current position to mouse position

func _process(_delta):
	if isHolding: # If is holding
		speed = calculate_speed(global_position.distance_to(get_global_mouse_position())) # Calculate speed
		get_node("Indicators/ForceLength").value = int(speed / maxSpeed * 100) # Set force length indicator
	else:
		get_node("Indicators/ForceLength").value = 0 # Set force length indicator to default
	update() # Update draw

func _physics_process(delta):
	if velocity.length() < 1: # If is noising velocity
		velocity = Vector2(0, 0) # Set velocity to zero
		return

	if velocity.length() > 0: # If is moving
		velocity -= velocity.normalized() * deceleration * delta # Desaceleration

	var collision = move_and_collide(velocity * delta) # Move and get collisions

	if collision: # If has collision
		velocity = velocity.bounce(collision.normal) # Bounce ball with object
		velocity -= velocity.normalized() * (deceleration * 2.5) * delta # Apply extra deceleration

func _anim_enter_hole(hole):
	self.set_process_input(false) # Disable input

	var tween = Tween.new() # Create tween
	add_child(tween) # Add tween to node

	var transition_time = clamp((maxSpeed / abs(velocity.x)) * 0.05, 0.15, 0.3) # Calculate transition time

	velocity = Vector2(0, 0) # Set velocity to zero

	$GolfBallAudioPlayer.play_hole_enter_sound() # Play hole enter sound

	tween.interpolate_property(self, "position", self.position, hole.position, transition_time, Tween.TRANS_LINEAR, Tween.EASE_IN) # Position animation
	tween.interpolate_property(self, "modulate", Color(1, 1, 1), Color(0, 0, 0),  transition_time, Tween.TRANS_LINEAR, Tween.EASE_IN) # Color animation

	tween.start() # Start fade animation

	yield(tween, "tween_completed") # Wait tween animation complete

	tween.call_deferred("free") # Free tween animator
