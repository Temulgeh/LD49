extends Area2D


var timer = 5


func _physics_process(delta):
	if timer > 0:
		timer -= 1
		scale.x = 1.0 - (1.0 - scale.x) * (1.0 - scale.x)
		scale.y = 1.0 - (1.0 - scale.y) * (1.0 - scale.y)
	else:
		queue_free()
