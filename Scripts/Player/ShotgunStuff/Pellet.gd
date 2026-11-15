extends CharacterBody2D

var Direction
var Speed = 225
var DesiredPos

func _ready() -> void:
	Direction = (DesiredPos - global_position).normalized()

func _process(_delta: float) -> void:
	velocity = Direction * Speed
	move_and_slide()
