extends Area2D


func _ready():
	connect("body_entered", self, "aa")


func aa():
	print("oha oho fhif hoshi fhoiae f")
