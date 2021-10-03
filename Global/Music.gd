extends Node


var is_muted: bool = false
onready var player = $AudioStreamPlayer


func play_first_music():
	player.stream = preload("res://Global/Basseloop.wav")
	player.play()


func play_second_music():
	player.stream = preload("res://Global/Zicmu.mp3")
	player.play()


func _input(event):
	if event.is_action_pressed("mute"):
		is_muted = not is_muted
		AudioServer.set_bus_mute(1, is_muted)


func stop_music():
	player.playing = false


func _ready():
	play_first_music()
