extends KinematicBody2D


const SMOOTHING = .1
const DAMPING = 0.17

var noise = OpenSimplexNoise.new()

var shake_strength: float

onready var camera = $Camera2D


func _ready():
	CameraTracker.camera = self
	noise.period = 0.2
	noise.octaves = 2


func _physics_process(delta):
	move_and_slide((PlayerTracker.player_position() - global_position) * SMOOTHING / delta)
	camera.position.x = noise.get_noise_1d(OS.get_ticks_msec() / 1000.0) * shake_strength
	camera.position.y = noise.get_noise_1d(-OS.get_ticks_msec() / 1000.0) * shake_strength
	if shake_strength > 0.0:
		shake_strength -= DAMPING
		if shake_strength < 0.0:
			shake_strength = 0.0


func shake(strength: float):
	shake_strength = strength
