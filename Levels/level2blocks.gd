extends Node2D


onready var block_to_remove = $BLOCK_TO_REMOVE

var block_removed: bool = false


func _ready():
	PlayerTracker.player.connect("move", self, "remove_block")


func remove_block():
	if not block_removed:
		block_to_remove.queue_free()
		block_removed = true
