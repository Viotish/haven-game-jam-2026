extends Node2D

func _ready() -> void:
	GblPlayer.Reset()
	GblPlayer.NextScene = "res://Scenes/Levels/End.tscn"

func _process(_delta: float) -> void:
	GblPlayer.SceneName = "LEVEL 3"
	if GblPlayer.TryAgain: #efagafg
		GblPlayer.TryAgain = false
		GblPlayer.SceneName = "LEVEL 2"
		get_tree().reload_current_scene()
