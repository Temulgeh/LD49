extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var settings_texts = [
	"no",
	"No",
	"No.",
	"Seriously, no",
	"Who has the time to do this in a jam?",
	"No but like seriously we hardly have enough time to even finish the game, do you expect us to do a fancy settings menu? who do you think we are???",
	"Settings",
	"you thought it was settings didntcha but it was me, the developper!!!!!!!!!!",
	"(the actual dev not the ingame one)",
	"(yeah they're not real, sorry)",
	"(is this what it feels like to tell your children that santa doesn't exist??)",
	"ok, fine",
	"if you want to disable the music just press Ctrl + M",
	"what, you want more?",
	"I'm sorry, we really didn't have the time to do a settings menu",
	"but maybe",
	"maybe",
	"there's something else you'd be interested in?",
	"what if",
	"I tell you a secret",
	"in 3",
	"2",
	"1",
	"Settings",
	"IndexError: list index out of range",
	"haha jk i thought about this",
	"Settings"
]

var settings_text_index = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$CenterContainer/VBoxContainer/Button_start.connect("pressed", self, "startGame")
	$CenterContainer/VBoxContainer/Button_settings.connect("pressed", self, "changeSettingsName")
	Music.play_first_music()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func changeSettingsName():
	$CenterContainer/VBoxContainer/Button_settings.text = settings_texts[settings_text_index]
	if settings_text_index < len(settings_texts) - 1:
		settings_text_index += 1


func startGame():
	get_tree().change_scene("res://Levels/Viewport0.tscn")
