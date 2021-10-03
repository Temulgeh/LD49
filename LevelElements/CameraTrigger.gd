extends Area2D

export var offset: Vector2
var active: bool


func _ready():
	connect("body_entered", self, "enter")
	connect("body_exited", self, "leave")


func enter(body: Node):
	if not active:
		CameraTracker.camera.offset += offset
		active = true


func leave(body: Node):
	if active:
		CameraTracker.camera.offset -= offset
		active = false
