extends ViewportContainer


onready var dialog3A = preload("res://addons/dialogic/Dialog3A.tscn")
onready var dialog3B = preload("res://addons/dialogic/Dialog3B.tscn")
onready var dialog3A_instance = dialog3A.instance()
onready var dialog3B_instance = dialog3B.instance()
onready var cmd = get_parent().get_node("WindowDialog")


func _ready():
	PlayerTracker.player.can_move = false
	get_parent().get_node("Dialog").add_child(dialog3A_instance)
	dialog3A_instance.connect("dialogic_signal", self, "command")


func command(message):
	dialog3A_instance.disconnect("dialogic_signal", self, "command")
	dialog3A_instance.connect("dialogic_signal", self, "end_of_3A")
	cmd.typeToCmd("Weapon.noCharge = true", 1.0, 0.0, 0.0)
	yield(cmd, "command_sent")
	cmd.sendReturnText("Updated Weapon.")
	cmd.closeCmd(2.0)
	PlayerTracker.player.actual_overcharge_time = 0


func end_of_3A(message):
	PlayerTracker.player.can_move = true
	PlayerTracker.player.connect("charged_shot", self, "start_3B")


func start_3B():
	get_parent().get_node("Dialog").add_child(dialog3B_instance)
	PlayerTracker.player.disconnect("charged_shot", self, "start_3B")
