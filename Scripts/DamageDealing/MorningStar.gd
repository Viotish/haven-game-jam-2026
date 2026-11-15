extends DamageDealer

@export var SpinsBackwards = false

func _ready() -> void:
	if SpinsBackwards:
		$AnimationPlayer.play_backwards("Spin")
	else: $AnimationPlayer.play("Spin")

func _process(_delta: float) -> void:
	$CollisionShape2D.global_position = $Sprite2D/GPUParticles2D.global_position
