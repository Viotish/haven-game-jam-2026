extends CanvasLayer

func _ready() -> void:
	SceneStarter()
	$DeathScreen/TryAgain.disabled = true

var Change = false
func _process(_delta: float) -> void:
	Bullets()
	Reload()
	CheckpointSlimeCheck()
	Death()
	
	if GblPlayer.ChangeScene:
		GblPlayer.ChangeScene = false
		$NewScene/SceneStarter.play("Darken")

func Bullets():
	match GblPlayer.Bullets:
		2:
			$Bullets/Bullet1.texture = load("res://Assets/UI/BulletFull.png")
			$Bullets/Bullet2.texture = load("res://Assets/UI/BulletFull.png")
		1:
			$Bullets/Bullet1.texture = load("res://Assets/UI/BulletEmpty.png")
			$Bullets/Bullet2.texture = load("res://Assets/UI/BulletFull.png")
		0:
			$Bullets/Bullet1.texture = load("res://Assets/UI/BulletEmpty.png")
			$Bullets/Bullet2.texture = load("res://Assets/UI/BulletEmpty.png")

func Reload():
	if ((Input.is_action_just_pressed("Reload") and GblPlayer.Bullets != 2) or GblPlayer.Bullets == 0) and !$Bullets/TextureProgressBar/ReloadAnim.is_playing() :
		$Bullets/TextureProgressBar/ReloadAnim.play("Reload")
func _on_reload_anim_animation_finished(_anim_name: StringName) -> void:
	GblPlayer.Bullets = 2

func CheckpointSlimeCheck():
	if GblPlayer.CheckpointSlimes >0:
		$CheckpointSlime.texture = load("res://Assets/UI/CheckpointSlime.png")
	else:
		$CheckpointSlime.texture = load("res://Assets/UI/CheckpointSlimeEmpty.png")
	$CheckpointSlime/Label.text = str(GblPlayer.CheckpointSlimes)

func Death():
	if GblPlayer.Hp <= 0 and GblPlayer.Dead != true:
		GblPlayer.Dead = true
		$DeathScreen/AnimationPlayer.play("new_animation")
	
	if GblPlayer.Respawn:
		GblPlayer.Respawn = false
		$DeathScreen/AnimationPlayer.play("Respawn")

func SceneStarter():
	$NewScene/ColorRect/Label.text = GblPlayer.SceneName
	$NewScene/ColorRect/Label.show()
	$NewScene/SceneStarter.play("NewScene")
	GblPlayer.CanPlay = false

func _on_try_again_pressed() -> void:
	GblPlayer.TryAgain = true


func _on_scene_starter_animation_finished(anim_name: StringName) -> void:
	GblPlayer.CanPlay = true
	if anim_name == "Darken":
		get_tree().change_scene_to_file(GblPlayer.NextScene)
