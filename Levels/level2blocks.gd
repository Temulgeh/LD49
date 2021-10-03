extends Node2D


onready var block_to_remove = $BLOCK_TO_REMOVE


func _ready():
	pass


func remove_block():
	block_to_remove.queue_free()
