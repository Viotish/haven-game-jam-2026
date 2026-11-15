extends CharacterBody2D

var Speed = 150
var DesiredPos
var Direction
func _ready() -> void:
	look_at(DesiredPos)
	Direction = (DesiredPos - global_position).normalized()

func _process(_delta: float) -> void:
	velocity = Direction * Speed
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body != $".":
		queue_free()
