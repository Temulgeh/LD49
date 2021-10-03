extends Control
#
#
## Declare member variables here. Examples:
## var a = 2
## var b = "text"
#
## Called when the node enters the scene tree for the first time.
#func _ready():

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerTracker.player.connect("just_died", self, "dieEvent")


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		$Pause_menu.visible = true
#		$WindowDialog.visible = false
#		$Dialogues.focus_mode = Control.FOCUS_NONE
#		$Dialogues.visible = false
		get_tree().paused = true

func dieEvent():
	$GameOver_menu.visible = true
	get_tree().paused = true
#	if $WindowDialog.isopen:
#		$ViewportContainer/Viewport.gui_disable_input = true
#	else:
#		$ViewportContainer/Viewport.gui_disable_input = false
	pass
