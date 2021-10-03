extends Area2D


export var next_level: String

var can_end_level: bool = true


func _ready():
	connect("body_entered", self, "end_level")


func end_level(body):
	if can_end_level:
		get_tree().change_scene(next_level)
