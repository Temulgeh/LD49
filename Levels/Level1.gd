extends ViewportContainer

onready var dialog1 = load("res://addons/dialogic/Dialog.tscn")
onready var diag1Instance = dialog1.instance()

onready var door = $Viewport/Level1/Door
onready var timer = $Timer

onready var cmd = get_parent().get_node("WindowDialog")


func _ready():
	PlayerTracker.player.connect("charged_shot", self, "first_interraction")


func first_interraction():
	PlayerTracker.player.disconnect("charged_shot", self, "first_interraction")
	get_parent().get_node("Dialog").add_child(diag1Instance)
	Music.stop_music()
	diag1Instance.connect("dialogic_signal", self, "block_exit")


#func _exit_tree():
#	diag1Instance.disconnect("dialogic_signal", self, "block_exit")


func block_exit(value):
	door.can_end_level = bool(int(value))
	if value == "1":
		Music.play_second_music()
		cmd.openCmd()
		
		cmd.typeToCmd("waepon.makeWeaker()", 0.8, 0.0, 0.0)
		yield(cmd, "command_sent")
		cmd.sendReturnText("Identifier \"waepon\" not found. Did you mean Weapon?")
		cmd.wrongCommand()
		timer.wait_time = 0.5
		timer.start()
		yield(timer, "timeout")
		
		cmd.typeToCmd("Weapon.makeWeaker()", 0.8, 0.0, 0.0)
		yield(cmd, "command_sent")
		cmd.sendReturnText("Method \"makeWeaker\" not found.")
		cmd.wrongCommand()
		timer.wait_time = 1.0
		timer.start()
		yield(timer, "timeout")
		
		cmd.typeToCmd("Weapon.strength -= 100000000000", 1.3, 0.0, 0.0)
		yield(cmd, "command_sent")
		cmd.sendReturnText("Successfully created member \"strength\".")
		timer.wait_time = 1.0
		timer.start()
		yield(timer, "timeout")
		
		cmd.typeToCmd("verify", 0.5, 0.0, 0.0)
		yield(cmd, "command_sent")
		cmd.sendReturnText("0 errors - 2540 warnings; Do you want to run tests? (Y/n)")
		timer.wait_time = 0.2
		timer.start()
		yield(timer, "timeout")
		
		cmd.typeToCmd("n", 0.1, 0.0, 0.0)
		yield(cmd, "command_sent")
		
		cmd.closeCmd(1.5)
