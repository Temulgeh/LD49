extends Area2D


export var next_level: String


func _ready():
	connect("body_entered", self, "end_level")


func end_level(body):
	get_tree().change_scene(next_level)
