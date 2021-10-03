extends TextureRect


func _ready():
	$Timer.start()
	$Timer.connect("timeout", self, "blink")


func blink():
	visible = randi() % 2
