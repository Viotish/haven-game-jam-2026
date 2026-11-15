extends Control

func _ready() -> void:
	$AnimationPlayer.play("St1")
	$St3.visible = true
	$St3.modulate = Color("#fff")

var Num = 1
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Enter") and !$AnimationPlayer.is_playing():
		match Num:
			1:
				$AnimationPlayer.play("St2")
			2:
				$AnimationPlayer.play("St3")
			3:
				$AnimationPlayer.play("St4")
			4:
				$AnimationPlayer.play("St5")
		Num += 1



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "St5":
		GblPlayer.SceneName = "TUTORIAL"
		get_tree().change_scene_to_file("res://Scenes/Levels/Tutorial.tscn")
