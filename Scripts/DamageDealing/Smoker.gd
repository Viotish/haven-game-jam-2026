extends CharacterBody2D

var IsActive = true

func _ready() -> void:
	$AnimationPlayer.play("Appear")
	$Timer.wait_time = 2.0
	$Timer.start()
	$CollisionShape2D.disabled = false

func _on_timer_timeout() -> void:
	match IsActive:
		true:
			$AnimationPlayer.play_backwards("Appear")
			$Timer.wait_time = 1.5
			$CollisionShape2D.disabled = true
		false:
			$AnimationPlayer.play("Appear")
			$Timer.wait_time = 2.0
			$CollisionShape2D.disabled = false
	IsActive = !IsActive
	$Timer.start()
