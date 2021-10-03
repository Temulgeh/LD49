extends Area2D

export var point: Vector2
export var weight: float
var active: bool


func _ready():
	connect("body_entered", self, "enter")
	connect("body_exited", self, "leave")


func enter(body: Node):
	if not active:
		CameraTracker.camera.other_target = point
		CameraTracker.camera.other_target_weight = weight
		active = true


func leave(body: Node):
	if active:
		CameraTracker.camera.other_target_weight = 0.0
		active = false
