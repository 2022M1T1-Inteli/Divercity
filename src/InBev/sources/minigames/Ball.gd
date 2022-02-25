extends KinematicBody2D

export var deceleration = 100
export var max_speed = 600
export var max_reach = 250

var is_holding = false
var start_position = Vector2.ZERO
var drop_direction = Vector2.ZERO

var velocity = Vector2()
var speed = 0

func calculate_speed(distance):
	distance = clamp(distance, 0, max_reach)
	distance = range_lerp(distance, 0, max_reach, 0, max_speed)
	return distance

func _input(event):
	if velocity.length() > 0:
		return

	if event is InputEventScreenTouch:
		if event.pressed:
			start_position = get_global_mouse_position()
			is_holding = true

		if not event.pressed:
			drop_direction = get_global_mouse_position().direction_to(global_position)

			is_holding = false
			velocity = Vector2(speed, 0).rotated(drop_direction.angle())


func _draw():
	if is_holding:
		draw_line(global_position - position, get_global_mouse_position() - position, Color.black, 5, true)

func _process(_delta):
	if is_holding:
		speed = calculate_speed(global_position.distance_to(get_global_mouse_position()))
		get_node("../Indicator/ForceLength").value = int(speed / max_speed * 100)
	else:
		get_node("../Indicator/ForceLength").value = 0
	update()


func _physics_process(delta):
	if velocity.length() < 1:
		velocity = Vector2()
		return

	if velocity.length() > 0:
		velocity -= velocity.normalized() * deceleration * delta

	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		velocity -= velocity.normalized() * (deceleration * 2.5) * delta
