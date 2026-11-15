extends CharacterBody2D

#region VARIABLES

var Speed = 100
var DesiredPos : Vector2
var Direction

var RecoilVelocity = Vector2.ZERO

@onready var BulletsPath = load("res://Scenes/Player/Bullets.tscn")
@onready var DoubleJumpCloudPath = load("res://Scenes/Player/DoubleJumpCloud.tscn")
@onready var SlimeCheckpointPath = load("res://Scenes/Player/CheckpointSlime.tscn")

#endregion


#region PROCESS AND READY STUFF

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if GblPlayer.CanPlay:
		GblPlayer.GblPos = global_position
		#CameraStuff()
		Shotgun()
		Movement(delta)
		Checkpoint()

#endregion

#region MOVEMENT

var JumpVelocity = -150
var Gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var IsOnFloor
func Movement(delta : float):
	if Input.is_action_pressed("Left"): $AnimatedSprite2D.flip_h = true
	if Input.is_action_pressed("Right"): $AnimatedSprite2D.flip_h = false
	
	if Input.is_action_just_pressed("Jump"):
		if is_on_floor():
			velocity.y = JumpVelocity
			$AnimatedSprite2D.stop()
			$AnimatedSprite2D.play("jump")
			IsMidAir = true
		elif GblPlayer.DoubleJump !=0:
			GblPlayer.DoubleJump = 0
			velocity.y = JumpVelocity
			$AnimatedSprite2D.stop()
			$AnimatedSprite2D.play("jump")
			var DoubleJumpCloud = DoubleJumpCloudPath.instantiate()
			DoubleJumpCloud.global_position = global_position
			get_tree().current_scene.add_child(DoubleJumpCloud)
			IsMidAir = true
	
	if not is_on_floor():
		$AnimatedSprite2D/FallAnimTime.start()
		IsMidAir = true
		velocity.y += Gravity * delta
		if IsFalling == true:
			$AnimatedSprite2D.play("fall")
	else: 
		IsFalling = false
		IsMidAir = false
		GblPlayer.DoubleJump = 1
	
	Direction = null
	if IsMidAir == false:
		Direction = Input.get_axis("Left", "Right")
		if velocity.x == 0:
			$AnimatedSprite2D.play("default")
		else:
			$AnimatedSprite2D.play("movement")
	else:
		if get_global_mouse_position().x > global_position.x:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true
	
	
	if Direction != null:
		velocity.x = Direction * Speed
	
	velocity += RecoilVelocity 
	move_and_slide()
	
	if $AnimatedSprite2D.flip_h:
		$AnimatedSprite2D/ShotgunParticles.scale.x = -1
	else:
		$AnimatedSprite2D/ShotgunParticles.scale.x = 1

var IsMidAir = false
var IsFalling = true
func _on_fall_anim_time_timeout() -> void:
	IsFalling = true

#endregion

#region SHOTGUN
var Frames = 0
var IsRecoil = false
func Shotgun():
	if Input.is_action_just_pressed("Shoot") and GblPlayer.Bullets:
		GblPlayer.Bullets -=1
		var Bullets = BulletsPath.instantiate()
		Bullets.global_position = global_position
		Bullets.look_at(get_global_mouse_position())
		get_tree().current_scene.add_child(Bullets)
		IsRecoil = true
		Frames = 5
		RecoilVelocity.x = (Frames*20) * (global_position - get_global_mouse_position()).normalized().x
		RecoilVelocity.y = (Frames*20) * (global_position - get_global_mouse_position()).normalized().y
		if get_global_mouse_position().x > global_position.x:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true
		
	
	if Frames > 0:
		RecoilVelocity.x = (Frames*40) * (global_position - get_global_mouse_position()).normalized().x
		RecoilVelocity.y = (Frames*20) * (global_position - get_global_mouse_position()).normalized().y
		Frames -= 1
	else: 
		RecoilVelocity = Vector2.ZERO
		IsRecoil = false

#endregion

#region SLIMECHECKPOINTS
var CheckpointId = 1
func Checkpoint():
	if Input.is_action_just_pressed("Checkpoint") and GblPlayer.CheckpointSlimes > 0:
		GblPlayer.CheckpointSlimes -= 1
		var SlimeCheckpoint = SlimeCheckpointPath.instantiate()
		SlimeCheckpoint.global_position = global_position
		SlimeCheckpoint.Id = CheckpointId
		GblPlayer.Checkpoints.append(global_position)
		GblPlayer.SlimeIds.append(CheckpointId)
		CheckpointId += 1
		get_tree().current_scene.add_child(SlimeCheckpoint)

#region HITBOX


func _on_hitbox_body_entered(_body: Node2D) -> void:
	
	GblPlayer.Hp = 0
	if !GblPlayer.Checkpoints.is_empty() and !GblPlayer.Dead:
		GblPlayer.Respawn = true
		global_position = GblPlayer.Checkpoints.pop_back()
		velocity = Vector2.ZERO
		RecoilVelocity = Vector2.ZERO
		GblPlayer.DeleteId = GblPlayer.SlimeIds.pop_back()
		GblPlayer.Hp = 1

#endregion

#region CAMERA

func CameraStuff():
	if global_position.distance_to(get_global_mouse_position()) < 16:
		$Camera2D.global_position = global_position
	else:
		$CameraJoint.look_at(get_global_mouse_position())
		if global_position.distance_to(get_global_mouse_position()) > 32:
			$CameraJoint/Pos.position.x = 32
		else:
			$CameraJoint/Pos.position.x = global_position.distance_to(get_global_mouse_position())
		$Camera2D.global_position = $CameraJoint/Pos/CamHolder.global_position

#endregion
