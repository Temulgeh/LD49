extends KinematicBody2D


export var bob_direction: Vector2 = Vector2.DOWN
export var second_bob_phase: bool = false

const BOB_DEPTH = 5.0

const DETECTION_RADIUS = 80.0
const FOLLOW_RADIUS = 130.0

const CHASE_ACCELERATION = 2.0
const BOB_ACCELERATION = 1.5
const FRICTION = 0.97

var home_position: Vector2
var velocity: Vector2
var chasing: bool

onready var animation_player = $AnimationPlayer


func _ready():
	home_position = position
	animation_player.play("Glow")


func _physics_process(delta):
	var vector_to_target: Vector2
	var radius: float
	if chasing:
		radius = FOLLOW_RADIUS
	else:
		radius = DETECTION_RADIUS
	var vector_to_player = PlayerTracker.player_position() - global_position
	if vector_to_player.length_squared() < radius * radius:
		vector_to_target = vector_to_player
		chasing = true
	else:
		chasing = false
		var dot = (position - home_position).dot(bob_direction * BOB_DEPTH)
		if dot > BOB_DEPTH * BOB_DEPTH:
			second_bob_phase = true
		elif dot < -BOB_DEPTH * BOB_DEPTH:
			second_bob_phase = false
		if second_bob_phase:
			vector_to_target = (home_position - bob_direction * BOB_DEPTH) - position
		else:
			vector_to_target = (home_position + bob_direction * BOB_DEPTH) - position
	var current_acceleration: float
	if chasing:
		current_acceleration = CHASE_ACCELERATION
	else:
		current_acceleration = BOB_ACCELERATION
	velocity += vector_to_target.normalized() * current_acceleration
	velocity *= FRICTION
	move_and_slide(velocity)
	
	if chasing:
		animation_player.playback_speed = 2.0
	else:
		animation_player.playback_speed = 1.0


func get_hit():
	queue_free()
