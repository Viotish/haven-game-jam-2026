extends Control

func _ready() -> void:
	$AnimationPlayer.play("new_animation")
func _on_button_pressed() -> void:
	$AnimationPlayer.play("Darken")



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Darken":
		get_tree().change_scene_to_file("res://Scenes/UI/Story.tscn")
