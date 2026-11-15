extends Node2D

@onready var ProjectilePath = load("res://Scenes/DamageDealing/Projectile.tscn")

func _ready() -> void:
	$Timer.start()

func _on_timer_timeout() -> void:
	var Projectile = ProjectilePath.instantiate()
	Projectile.global_position = $ProjectileSPawn.global_position
	Projectile.DesiredPos = $Target.global_position
	get_tree().current_scene.add_child(Projectile)
