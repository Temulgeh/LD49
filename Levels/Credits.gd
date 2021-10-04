extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var cmd = $WindowDialog
onready var timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready():
	
	cmd.size = Vector2(900, 500)
	cmd.position = Vector2(get_viewport_rect().size.x / 2.0 - cmd.size.x / 2.0, get_viewport_rect().size.y / 2.0 - cmd.size.y / 2.0)
	
	cmd.openCmd()
	cmd.typeToCmd("import Credits", 1, 0.5, 1)
	yield(cmd, "command_sent")
	cmd.typeToCmd("get_TeamMembers(order=\"random\").name", 2, 0.5, 1)
	yield(cmd, "command_sent")
	
	timer.wait_time = 1
	timer.start()
	yield(timer, "timeout")
	
	cmd.sendReturnText("[")
	
	timer.wait_time = 0.2
	timer.start()
	yield(timer, "timeout")
	
	cmd.sendReturnText("temul,")
	
	timer.wait_time = 1
	timer.start()
	yield(timer, "timeout")
	
	cmd.sendReturnText("Tetane,")
	
	timer.wait_time = 1
	timer.start()
	yield(timer, "timeout")
	
	cmd.sendReturnText("Louis G")
	
	timer.wait_time = 0.2
	timer.start()
	yield(timer, "timeout")
	
	cmd.sendReturnText("]")
	
	timer.wait_time = 0.2
	timer.start()
	yield(timer, "timeout")
	
	cmd.typeToCmd("get_VoiceActors(order=\"random\").name", 2, 0.5, 0.5)
	yield(cmd, "command_sent")
	
	timer.wait_time = 0.1
	timer.start()
	yield(timer, "timeout")
	
	cmd.sendReturnText("[")
	
	timer.wait_time = 0.2
	timer.start()
	yield(timer, "timeout")
	
	cmd.sendReturnText("Valentin Geffroy")
	
	timer.wait_time = 0.2
	timer.start()
	yield(timer, "timeout")
	
	cmd.sendReturnText("]")
	
	timer.wait_time = 0.2
	timer.start()
	yield(timer, "timeout")
	
	cmd.typeToCmd("get_SpecialThanks(order=\"random\")", 2, 0.5, 0.5)
	yield(cmd, "command_sent")
	
	timer.wait_time = 0.2
	timer.start()
	yield(timer, "timeout")
	
	cmd.sendReturnText("[")
	
	timer.wait_time = 0.2
	timer.start()
	yield(timer, "timeout")
	
	cmd.sendReturnText("APOIL <3 <3 <3")
	
	timer.wait_time = 0.7
	timer.start()
	yield(timer, "timeout")
	
	cmd.sendReturnText("And you for playing our game! <3")
	
	timer.wait_time = 0.2
	timer.start()
	yield(timer, "timeout")
	
	cmd.sendReturnText("]")
	
	timer.wait_time = 0.2
	timer.start()
	yield(timer, "timeout")
	
	cmd.typeToCmd("Bye", 0.3, 0.5, 0.5)
	yield(cmd, "command_sent")
	
	timer.wait_time = 10
	timer.start()
	yield(timer, "timeout")
	
	cmd.typeToCmd("Why are you still here?", 1, 0.5, 0.5)
	
	timer.wait_time = 10
	timer.start()
	yield(timer, "timeout")
	
	cmd.typeToCmd("I'm sure you have better things to do...", 1, 0.5, 0.5)
	
	timer.wait_time = 10
	timer.start()
	yield(timer, "timeout")
	
	cmd.typeToCmd("Seriously...", 1, 0.5, 0.5)
	
	timer.wait_time = 10
	timer.start()
	yield(timer, "timeout")
	
	cmd.typeToCmd("...", 1, 0.5, 0.5)
	
	timer.wait_time = 10
	timer.start()
	yield(timer, "timeout")
	
	cmd.typeToCmd("If you press \"Alt+f4\" you can access a bonus Level! ", 1, 0.5, 0.5)
	
	timer.wait_time = 10
	timer.start()
	yield(timer, "timeout")
	
	cmd.typeToCmd("please leave!", 1, 0.5, 0.5)
	
	timer.wait_time = 10
	timer.start()
	yield(timer, "timeout")
	
	cmd.typeToCmd("???", 1, 0.5, 0.5)
	
	timer.wait_time = 10
	timer.start()
	yield(timer, "timeout")
	
	cmd.typeToCmd("The next message will be awesome. Wait for it!", 1, 0.5, 0.5)
	
	
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
