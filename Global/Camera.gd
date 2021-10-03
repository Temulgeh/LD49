extends KinematicBody2D


const SMOOTHING = .05
const DAMPING = 0.17

var noise = OpenSimplexNoise.new()
var offset: Vector2 = Vector2(0, 0)
var other_target: Vector2
var other_target_weight: float

var shake_strength: float

onready var camera = $Camera2D


func _ready():
	CameraTracker.camera = self
	noise.period = 0.2
	noise.octaves = 2


func _physics_process(delta):
	var target = (PlayerTracker.player_position() + offset) * (1.0 - other_target_weight) + other_target * other_target_weight
	move_and_slide((target - global_position) * SMOOTHING / delta)
	camera.position.x = noise.get_noise_1d(OS.get_ticks_msec() / 1000.0) * shake_strength
	camera.position.y = noise.get_noise_1d(-OS.get_ticks_msec() / 1000.0) * shake_strength
	if shake_strength > 0.0:
		shake_strength -= DAMPING
		if shake_strength < 0.0:
			shake_strength = 0.0


func shake(strength: float):
	shake_strength = strength
