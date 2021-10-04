extends ViewportContainer


onready var dialog5A = preload("res://addons/dialogic/Dialog5A.tscn")
onready var dialog5A_instance = dialog5A.instance()


func _ready():
	get_parent().get_node("Dialog").add_child(dialog5A_instance)
	dialog5A_instance.connect("dialogic_signal", self, "rip")


func rip(message):
	print("aa")
	get_tree().change_scene("res://Levels/Credits.tscn")
