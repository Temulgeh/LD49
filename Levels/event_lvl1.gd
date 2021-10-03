extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var paused := false

# Called when the node enters the scene tree for the first time.
func _ready():
	var new_dialog = load("res://addons/dialogic/Dialog_2.tscn")
	var diagInstance = new_dialog.instance()
	
	
	
#	$Dialogues/DialogNode.set_process(false)
	$WindowDialog.typeToCmd("gunPower -= 100",0.3,0.2,0.0)
	yield($WindowDialog, "command_sent")
	$WindowDialog.typeToCmd("gunknockback -= 50",0.3,0.2,0.0)
	yield($WindowDialog, "command_sent")
	$WindowDialog.typeToCmd("bulletSpeed -= 20",0.3,0.2,0.0)
	yield($WindowDialog, "command_sent")
	$WindowDialog.typeToCmd("test3 += 28",0.3,0.2,0.0)
	yield($WindowDialog, "command_sent")
	$WindowDialog.typeToCmd("chibfguavevearega += 12",0.3,0.2,0.0)
	yield($WindowDialog, "command_sent")
	$WindowDialog.closeCmd(0.3)
	$Dialogues.add_child(diagInstance)
	$ViewportContainer/Viewport/TestLevel/Player.connect("just_died", self, "dieEvent")
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		$Pause_menu.visible = true
#		$WindowDialog.visible = false
#		$Dialogues.focus_mode = Control.FOCUS_NONE
#		$Dialogues.visible = false
		paused = true
		get_tree().paused = true

func dieEvent():
	$GameOver_menu.visible = true
	get_tree().paused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	if $WindowDialog.isopen:
#		$ViewportContainer/Viewport.gui_disable_input = true
#	else:
#		$ViewportContainer/Viewport.gui_disable_input = false
	pass
