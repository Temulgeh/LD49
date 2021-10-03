extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$CenterContainer/VBoxContainer/Button_resume.connect("pressed", self, "resumeGame")
	$CenterContainer/VBoxContainer/Button_exit.connect("pressed", self, "exitGame")
	$CenterContainer/VBoxContainer/Button_back2main.connect("pressed", self, "back2menu")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func resumeGame():
	self.visible = false
	get_tree().paused = false

func exitGame():
	get_tree().quit()

func back2menu():
	get_tree().change_scene("res://Menus/Main_menu/MainMenu.tscn")
	get_tree().paused = false
