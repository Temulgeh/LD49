extends ViewportContainer

onready var dialog1 = load("res://addons/dialogic/Dialog.tscn")
onready var diag1Instance = dialog1.instance()

func _ready():
	
	PlayerTracker.player.connect("charged_shot", self, "first_interraction")


func first_interraction():
	get_parent().get_node("Dialog").add_child(diag1Instance)
