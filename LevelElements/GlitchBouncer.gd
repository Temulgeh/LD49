extends Area2D


export var strength: float


func _ready():
	connect("body_entered", self, "bounce")


func bounce(body):
	body.velocity.y = -strength
