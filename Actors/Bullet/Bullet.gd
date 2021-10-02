extends KinematicBody2D


const small_explosion: PackedScene = preload("res://Actors/Bullet/SmallExplosion.tscn")

var velocity: Vector2
var health: int


func _ready():
	pass


func _physics_process(delta):
	var collision_data = move_and_collide(velocity)
	if collision_data:
		if collision_data.collider.has_method("get_hit"):
			collision_data.collider.get_hit()
		var small_explosion_instance = small_explosion.instance()
		get_parent().add_child(small_explosion_instance)
		small_explosion_instance.global_position = global_position
		health -= 1
		if health <= 0:
			queue_free()
