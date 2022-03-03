extends CenterContainer

func _process(_delta):
	if $ForceLength.value <= 0: # check if has input lenght
		visible = false # hide the bar
	else:
		visible = true # show the bar
