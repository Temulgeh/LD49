extends Node


var player: Node


func _ready():
	pass


func player_position() -> Vector2:
	return player.global_position
