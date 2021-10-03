extends ViewportContainer

onready var dialog1 = load("res://addons/dialogic/Dialog.tscn")
onready var diag1Instance = dialog1.instance()

onready var door = $Viewport/Level1/Door

func _ready():
	PlayerTracker.player.connect("charged_shot", self, "first_interraction")


func first_interraction():
	get_parent().get_node("Dialog").add_child(diag1Instance)
	diag1Instance.connect("dialogic_signal", self, "block_exit")


#func _exit_tree():
#	diag1Instance.disconnect("dialogic_signal", self, "block_exit")


func block_exit(value):
	door.can_end_level = bool(int(value))
