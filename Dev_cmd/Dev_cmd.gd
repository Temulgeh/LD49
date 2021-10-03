extends WindowDialog


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cmd_text := "test"
export var typed_char : int = 0
signal command_sent
var position : Vector2 = Vector2(700,300)
var size : Vector2 = Vector2(370,218)
var isopen := false
signal cmd_just_opened
signal cmd_just_closed
#var waitTime = 0.2

onready var audio_player = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
#	visible = true
	$VBoxContainer/RichTextLabel.scroll_following = true
	self.get_close_button().disabled = true
	self.get_close_button().visible = false
	$Tween.connect("tween_all_completed", self, "onFinishedTyping")
	$Timer.connect("timeout", self, "onCmdReturn")
	$TweenOpen.connect("tween_all_completed", self, "cmd_just_opened")
	$VBoxContainer/LineEdit.connect("gui_input", self, "testReturnCmd")
#	self.rect_global_position
#	self.rect_size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Tween.is_active():
		$VBoxContainer/LineEdit.text = cmd_text.substr(0, typed_char)

	
func typeToCmd(cmd_text:String, typingTime, waitingTime, delay):
	if !$Tween.is_active():
		if !isopen:
			openCmd()
			yield(self, "cmd_just_opened")
		if delay > 0:
			$TimerOC.wait_time = delay
			$TimerOC.start()
			yield($TimerOC, "timeout")
		self.cmd_text = cmd_text
		$Timer.wait_time = waitingTime
		$Tween.interpolate_property(self, "typed_char", 0, cmd_text.length(), typingTime)
		$VBoxContainer/LineEdit.text = ""
		typed_char = 0
		$Tween.start()
		audio_player.playing = true


func wrongCommand():
	$AnimationPlayer.play("Wrong_command")


func onCmdReturn():

	$VBoxContainer/RichTextLabel.add_text("> ")
	$VBoxContainer/RichTextLabel.add_text(self.cmd_text)
	$VBoxContainer/RichTextLabel.add_text("\n")
	$VBoxContainer/LineEdit.text = ""
	cmd_text = ""
	emit_signal("command_sent")

func onFinishedTyping():
	audio_player.playing = false
	$Timer.start()

func sendReturnText(returnText:String):
	$VBoxContainer/RichTextLabel.add_text(returnText)
	$VBoxContainer/RichTextLabel.add_text("\n")

func openCmd():
	if !isopen:
		visible = true
		$TweenOpen.interpolate_property(self, "rect_global_position", Vector2(0, get_parent_area_size().y), position,0.3)
		$TweenOpen.interpolate_property(self, "rect_size", Vector2(0,0), size,0.3)
		$TweenOpen.interpolate_property(self, "modulate", Color(1,1,1,0), Color(1,1,1,1),0.3)
		$TweenOpen.start()
		isopen = true


func closeCmd(delay):
	if isopen:
		if delay > 0:
			$TimerOC.wait_time = delay
			$TimerOC.start()
			yield($TimerOC, "timeout")
		isopen = false
		position = self.rect_global_position
		size = self.rect_size
		$TweenClose.interpolate_property(self, "rect_global_position", position, Vector2(0, get_parent_area_size().y),0.3)
		$TweenClose.interpolate_property(self, "rect_size", size, Vector2(0,0),0.3)
		$TweenClose.interpolate_property(self, "modulate", Color(1,1,1,1), Color(1,1,1,0),0.3)
		$TweenClose.start()
		emit_signal("cmd_just_closed")

func cmd_just_opened():
	isopen = true
	emit_signal("cmd_just_opened")
	
func testReturnCmd(event : InputEvent):
	if event.is_action_pressed("ui_accept"):
		$VBoxContainer/RichTextLabel.append_bbcode("[color=#FF0000]> "+$VBoxContainer/LineEdit.text+"[/color]")
		$VBoxContainer/RichTextLabel.add_text("\n")
			
		$VBoxContainer/LineEdit.text = ""
		$AnimationPlayer.play("Wrong_command")
