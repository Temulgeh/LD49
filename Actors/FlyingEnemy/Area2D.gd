extends Area2D


func _ready():
	connect("body_entered", self, "kill")


func kill(body):
	if body.has_method("get_hit_but_im_the_player"):
		body.get_hit_but_im_the_player()
