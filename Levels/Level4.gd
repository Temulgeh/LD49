extends ViewportContainer


onready var dialog4A = preload("res://addons/dialogic/Dialog4A.tscn")
onready var dialog4A_instance = dialog4A.instance()
onready var door = $Viewport/Level4/Door

var has_started: bool = false


func start4A():
	if not has_started:
		print("aaa")
		dialog4A_instance.connect("dialogic_signal", self, "block_exit")
		get_parent().get_node("Dialog").add_child(dialog4A_instance)
		has_started = true


func _process(delta):
	var ppos = PlayerTracker.player_position()
	print(ppos)
	if ppos.x > 100 and ppos.y < 40:
		start4A()


func block_exit(value):
	door.can_end_level = bool(int(value))
