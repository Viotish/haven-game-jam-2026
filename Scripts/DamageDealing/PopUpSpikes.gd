extends CharacterBody2D
var IsUp = true

func _ready() -> void:
	$AnimatedSprite2D.play("default")
	$Timer.start()



func _on_timer_timeout() -> void:
	match IsUp:
		true:
			$AnimatedSprite2D.play_backwards("default")
			$CollisionShape2D.disabled = true
		false:
			$AnimatedSprite2D.play("default")
			$CollisionShape2D.disabled = false
	
	IsUp = !IsUp
	
	
