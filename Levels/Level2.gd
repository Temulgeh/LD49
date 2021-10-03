extends ViewportContainer


onready var block_to_remove = $Viewport/Level2/Blocks/BLOCK_TO_REMOVE
onready var dialogA = load("res://addons/dialogic/Dialog2_level2.tscn")
onready var dialogB = load("res://addons/dialogic/Dialog2_level2_episode1.tscn")
onready var dialogC = load("res://addons/dialogic/Dialog2_level2_episode2.tscn")
onready var dialogA_instance = dialogA.instance()
onready var dialogB_instance = dialogB.instance()
onready var dialogC_instance = dialogC.instance()
onready var cmd = get_parent().get_node("WindowDialog")

var dialogA_happened: bool
var dialogB_happened: bool


func _ready():
	PlayerTracker.player.can_move = false
	get_parent().get_node("Dialog").add_child(dialogA_instance)
	dialogA_instance.connect("dialogic_signal", self, "dialogic_signal_handler")
	dialogB_instance.connect("dialogic_signal", self, "dialogic_signal_handler")
	dialogC_instance.connect("dialogic_signal", self, "dialogic_signal_handler")


func launch_dialogB():
	PlayerTracker.player.can_move = false
	get_parent().get_node("Dialog").add_child(dialogB_instance)


func launch_dialogC():
	PlayerTracker.player.can_move = false
	get_parent().get_node("Dialog").add_child(dialogC_instance)
	cmd.openCmd()
	cmd.connect("command_sent", self, "delete_block")
	cmd.typeToCmd("del -rf elementId(53482)", 0.5, 0.0, 0.0)
	yield(cmd, "command_sent")
	cmd.closeCmd(1.5)


func delete_block():
	block_to_remove.queue_free()


func dialogic_signal_handler(message):
	print(message)
	if message == "2Aend":
		PlayerTracker.player.can_move = true
		PlayerTracker.player.connect("charged_shot", self, "launch_dialogB")
	if message == "2Bend":
		PlayerTracker.player.can_move = true
		PlayerTracker.player.disconnect("charged_shot", self, "launch_dialogB")
		PlayerTracker.player.connect("move", self, "launch_dialogC")
	if message == "2Cend":
		PlayerTracker.player.can_move = true
		PlayerTracker.player.disconnect("move", self, "launch_dialogC")
