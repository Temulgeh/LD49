extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$CenterContainer/VBoxContainer/Button_restart.connect("pressed", self, "restartLvl")
	$CenterContainer/VBoxContainer/Button_mainMenu.connect("pressed", self, "back2menu")
	$CenterContainer/VBoxContainer/Button_exit.connect("pressed", self, "exitGame")

func restartLvl():
	get_tree().reload_current_scene()
	get_tree().paused = false

func back2menu():
	get_tree().change_scene("res://Menus/Main_menu/MainMenu.tscn")
	get_tree().paused = false

func exitGame():
	get_tree().quit()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
