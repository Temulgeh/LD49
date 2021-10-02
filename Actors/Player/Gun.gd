extends Node2D


const BULLET_SPEED = 15.0
const MAX_DISTANCE_FROM_PLAYER = 8.0

const bullet: PackedScene = preload("res://Actors/Bullet/Bullet.tscn")

onready var animation_player = $AnimationPlayer


func shoot(parent_node: Node, direction: Vector2, hits: int = 1):
	var bullet_instance = bullet.instance()
	bullet_instance.velocity = direction * BULLET_SPEED
	bullet_instance.health = hits
	parent_node.add_child(bullet_instance)
	bullet_instance.global_position = global_position
	animation_player.play("Shoot")
	animation_player.seek(0)
	CameraTracker.camera.shake(3)
