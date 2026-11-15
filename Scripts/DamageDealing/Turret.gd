extends Node2D

var State = "Idle"

@onready var ProjectilePath = load("res://Scenes/DamageDealing/Projectile.tscn")

func _process(_delta: float) -> void:
	if State == "Agro":
		$BarrelJoint.look_at(GblPlayer.GblPos)


func _on_area_2d_body_entered(_body: Node2D) -> void:
	State = "Agro"
	$BarrelJoint/Barrel.rotation_degrees = 90
	$Timer.start()



func _on_timer_timeout() -> void:
	var Projectile = ProjectilePath.instantiate()
	Projectile.global_position = $BarrelJoint/Barrel/Node2D.global_position
	Projectile.DesiredPos = GblPlayer.GblPos
	get_tree().current_scene.add_child(Projectile)
