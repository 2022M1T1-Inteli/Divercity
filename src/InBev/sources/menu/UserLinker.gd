extends Control

export var url = ""
export var username = ""

func _ready():
	$Label.text = username # set the label text

func _on_TouchScreenButton_pressed():
	OS.shell_open(url) # open the URL in the default browser
