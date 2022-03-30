extends Control

const BUS_NAMES = {
	MAIN = "Master",
	MUSIC = "Music",
	EFFECTS = "Effects",
}

func _ready():
	_update()

func _update():
	"""
		Call to update sliders with current volume
	"""
	$VolumeBlocks/MainSoundBlock/MainHSlider.value = db2linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index(BUS_NAMES.MAIN)))
	$VolumeBlocks/MusicSoundBlock/MusicHSlider.value = db2linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index(BUS_NAMES.MUSIC)))
	$VolumeBlocks/EffectSoundBlock/EffectsHSlider.value = db2linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index(BUS_NAMES.EFFECTS)))

func set_volume(busName, linearValue):
	"""
		Set volume of a bus in db metric
	"""

	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(busName), linear2db(linearValue))

func _on_ExitButton_pressed():
	get_tree().quit() # Quit game

func _on_EffectsHSlider_value_changed(value):
	set_volume(BUS_NAMES.EFFECTS, value) # Set volume of effects bus

func _on_MusicHSlider_value_changed(value):
	set_volume(BUS_NAMES.MUSIC, value) # Set volume of music bus

func _on_MainHSlider_value_changed(value):
	set_volume(BUS_NAMES.MAIN, value) # Set volume of main bus
