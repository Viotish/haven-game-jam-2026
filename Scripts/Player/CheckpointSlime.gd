extends Node2D

var Id
func _ready() -> void:
	$AnimatedSprite2D.play("default")

func _process(_delta: float) -> void:
	if GblPlayer.DeleteId == Id:
		queue_free()
