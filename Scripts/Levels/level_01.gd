extends Node2D

func _ready() -> void:
	GblPlayer.Reset()

	GblPlayer.NextScene = "res://Scenes/Levels/Level02.tscn"

func _process(_delta: float) -> void:
	GblPlayer.SceneName = "LEVEL 2"
	if GblPlayer.TryAgain:
		GblPlayer.TryAgain = false
		GblPlayer.SceneName = "LEVEL 1"
		get_tree().reload_current_scene()
