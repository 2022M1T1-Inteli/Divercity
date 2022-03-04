extends KinematicBody2D

var speed = 100
var patrolPoints = null
var patrolIndex = 0
var velocity = Vector2.ZERO

func _construct(mainNode):
	get_parent().connect("go_to_golf", mainNode, "_change_scene_to") # Connect callback for local signal

func _ready():
	var timer = Timer.new() # Create a new timer
	timer.set_wait_time(0.75) # Set the wait time
	timer.set_one_shot(true) # Set the timer to one shot
	self.add_child(timer) # Add the timer to the scene as a child
	timer.start() # Start the timer
	yield(timer, "timeout") # Wait for the timer to timeout
	timer.call_deferred("free") # Free the timer

	patrolPoints = get_node("../FirstMinigamePath").curve.get_baked_points() # get the points from the path
	$AnimatedSprite.play("Walking") # play the walking animation

func _physics_process(_delta):
	if patrolPoints == null: # if the patrol points are null return out of the function
		return

	if patrolPoints.size() == patrolIndex + 1: # -
		$AnimatedSprite.play("Stopped") # if we're at the end of the path, stop
		get_parent().emit_signal("go_to_golf", "res://scenes/minigames/golf/Golf.tscn") # emit the signal to change the scene
		patrolPoints = null # set the patrol points to null
		return

	var target = patrolPoints[patrolIndex] # get the current point

	if position.distance_to(target) < 1: # if we are close enough to the point
		patrolIndex = wrapi(patrolIndex + 1, 0, patrolPoints.size()) # move to the next point
		target = patrolPoints[patrolIndex] # get the new point

	velocity = (target - position).normalized() * speed # get the direction to the point
	velocity = move_and_slide(velocity) # move the body
