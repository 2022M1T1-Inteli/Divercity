extends Control


signal change_scene # Create local signal for change to game scene

export(String) var callbackScenePath
export(Dictionary) var callbackSceneParams


func _construct(mainNode):
	"""
		Node constructor
	"""
	connect("change_scene", mainNode, "_change_scene_to") # Connect callback for local signal

func _ready():
	get_node("AnimationPlayer").play("Scroll")



func _on_AnimationPlayer_animation_finished(anim_name):
	LevelManager.currentLevel = -1 # Reset current level
	emit_signal("change_scene", callbackScenePath, true, callbackSceneParams) # Emit the change scene signal to the game scene
