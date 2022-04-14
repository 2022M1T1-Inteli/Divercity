extends Control

const BUS_NAMES = {
	MAIN = "Master",
	MUSIC = "Music",
	EFFECTS = "Effects",
}

func _ready():
	_update() # update once to make sure the bus is updated

func _update():
	"""
		Call to update sliders with current volume
	"""
	$VolumeBlocks/MainSoundBlock/MainHSlider.value = db2linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index(BUS_NAMES.MAIN))) # Update Main Bus volume
	$VolumeBlocks/MusicSoundBlock/MusicHSlider.value = db2linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index(BUS_NAMES.MUSIC))) # Update Music Bus volume
	$VolumeBlocks/EffectSoundBlock/EffectsHSlider.value = db2linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index(BUS_NAMES.EFFECTS))) # Update Effects Bus volume

	$VersionLabel.text = "Versão do jogo: %s" % VersionManager.version # Update version label

func set_volume(busName, linearValue):
	"""
		Set volume of a bus in db metric
	"""

	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(busName), linear2db(linearValue)) # Set volume with conversion of linear value to db value

func _on_ExitButton_pressed():
	get_tree().quit() # Quit game

func _on_EffectsHSlider_value_changed(value):
	set_volume(BUS_NAMES.EFFECTS, value) # Set volume of effects bus

func _on_MusicHSlider_value_changed(value):
	set_volume(BUS_NAMES.MUSIC, value) # Set volume of music bus

func _on_MainHSlider_value_changed(value):
	set_volume(BUS_NAMES.MAIN, value) # Set volume of main bus


func _on_CreditsButton_pressed():
	$CreditsLayer.show_self() # Show credits layer

func _on_RestartButton_pressed():
	LevelManager.currentLevel = -1 # Reset current level
	print(get_tree().get_root().get_node("MainScene"))
	get_tree().get_root().get_node("MainScene")._change_scene_to("res://scenes/menu/Menu.tscn", true) # Change scene to menu
