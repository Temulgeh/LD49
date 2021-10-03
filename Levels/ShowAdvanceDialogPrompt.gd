extends Sprite


func _ready():
	PlayerTracker.player.connect("charged_shot", self, "show")


func show():
	visible = true
