extends Area2D

signal golfball_entered

func _on_Area2D_body_entered(body): # check collisions
	if body.name == "GolfBall": # if the body is the golf ball
		emit_signal("golfball_entered") # emit the signal of golf ball collision
