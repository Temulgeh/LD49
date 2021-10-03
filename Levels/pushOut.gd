extends Area2D


func _ready():
	connect("body_entered", self, "push")


func push(body):
	body.velocity = Vector2(-10, -5)
