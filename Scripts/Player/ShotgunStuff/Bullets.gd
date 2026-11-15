extends CharacterBody2D

@onready var PelletPath = load("res://Scenes/Player/Pellet.tscn")

var Pellets : Array

func _ready():
	Pellets.resize(10)
	$AnimationPlayer.play("FadeInAway")
	for i in range(9):
		Pellets[i] = PelletPath.instantiate()
		Pellets[i].DesiredPos = $Joint/DirPos.global_position
		add_child(Pellets[i])
		$Joint.rotation_degrees += 5

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()
