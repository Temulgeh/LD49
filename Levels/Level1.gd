extends ViewportContainer


func _ready():
	PlayerTracker.player.connect("charged_shot", self, "first_interraction")


func first_interraction():
	pass
