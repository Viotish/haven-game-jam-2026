extends Node

var GblPos = Vector2.ZERO

var Dead = false
var Hp = 1
var Bullets = 2
var DoubleJump = 1
var CheckpointSlimes = 2
var Respawn = false
var Checkpoints : Array[Vector2] = []
var SlimeIds : Array[int] = []
var DeleteId = 0

var CanPlay = false

var SceneName = ""

var TryAgain = false

var ChangeScene = false
var NextScene

func Reset():
	GblPos = Vector2.ZERO
	Dead = false
	Hp = 1
	Bullets = 2
	DoubleJump = 1
	CheckpointSlimes = 2
	Respawn = false
	Checkpoints = []
	SlimeIds  = []
	DeleteId = 0
	TryAgain = false
