extends Node2D

func _ready() -> void:
	GblPlayer.Reset()
	
	GblPlayer.NextScene = "res://Scenes/Levels/Level01.tscn"

func _process(_delta: float) -> void:
	GblPlayer.SceneName = "LEVEL 1"
	if GblPlayer.TryAgain:
		GblPlayer.TryAgain = false
		GblPlayer.SceneName = "TUTORIAL"
		get_tree().reload_current_scene()
