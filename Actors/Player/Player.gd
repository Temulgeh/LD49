extends KinematicBody2D


const COYOTE_TIME = 5
const JUMP_INPUT_TIME = 6

const JUMP_FORCE = 3.4
const HIGH_JUMP_GRAVITY_MULTIPLIER = .2
const HIGH_JUMP_TIME = 12
const JUMP_PEAK_THRESHOLD = 0.6
const JUMP_PEAK_GRAVITY_MULTIPLIER = .5
const JUMP_HORIZONTAL_BOOST = 1.5
const GRAVITY = .27
const MAX_GRAVITY = 7.0
const RUNNING_SPEED = 2.0
const ACCUMULATION_ON_IMPULSE = .5
const GROUND_ACCELERATION_TIME = 10
const AIR_ACCELERATION_TIME = 30
const MOVEMENT_EPSILON = .05
const CORRECTION_LINEAR_FRICTION = 0.5

const OVERCHARGE_TIME = 40
const OVERCHARGE_EXPLOSION_BOOST_STRENGTH = 20.0
const BOUNCE_MULTIPLIER = 0.5
const BOOSTING_THRESHOLD = 2 * RUNNING_SPEED

const MIN_ANIMATION_SPEED = 0.5
const ANIMATION_SPEED_SLOPE = 1.0

var ground_friction: float
var ground_acceleration: float
var air_friction: float
var air_acceleration: float

var velocity: Vector2
var direction: int
var facing: int
var coyote_timer: int
var jump_input_timer: int
var high_jump_timer: int
var grounded: bool
var high_jumping: bool

var charge_timer: int
var can_shoot: bool = true

var block_charge: bool

signal just_died
signal charged_shot
signal move

onready var display = $PlayerDisplay
onready var gun = $PlayerDisplay/Gun
onready var animation_player = $AnimationPlayer


func _input(event):
	if event.is_action_pressed("ui_left"):
		direction = -1
	elif event.is_action_pressed("ui_right"):
		direction = 1
	elif event.is_action_released("ui_left"):
		if Input.is_action_pressed("ui_right"):
			direction = 1
		else:
			direction = 0
	elif event.is_action_released("ui_right"):
		if Input.is_action_pressed("ui_left"):
			direction = -1
		else:
			direction = 0
	elif event.is_action_pressed("ui_up"):
		jump_input_timer = JUMP_INPUT_TIME
	elif event.is_action_released("ui_accept"):
		if can_shoot:
			gun.shoot(get_parent(), Vector2.RIGHT * facing)
		else:
			can_shoot = true
		charge_timer = 0


func _ready():
	PlayerTracker.player = self
	facing = 1
	ground_friction = pow(MOVEMENT_EPSILON / RUNNING_SPEED, 1.0 / GROUND_ACCELERATION_TIME)
	ground_acceleration = RUNNING_SPEED * (1.0 - ground_friction)
	air_friction = pow(MOVEMENT_EPSILON / RUNNING_SPEED, 1.0 / AIR_ACCELERATION_TIME)
	air_acceleration = RUNNING_SPEED * (1.0 - air_friction)
	animation_player.play("PlayerBounce")


func _physics_process(delta):
	var current_gravity = GRAVITY
	if high_jumping:
		if Input.is_action_pressed("ui_up"):
			if high_jump_timer > 0:
				current_gravity *= HIGH_JUMP_GRAVITY_MULTIPLIER
				high_jump_timer -= 1
			else:
				if abs(velocity.y) < JUMP_PEAK_THRESHOLD:
					current_gravity *= JUMP_PEAK_GRAVITY_MULTIPLIER
		else:
			high_jumping = false
	velocity.y = min(velocity.y + current_gravity, MAX_GRAVITY)
	
	if grounded:
		high_jumping = false
		coyote_timer = COYOTE_TIME
	
	if jump_input_timer > 0 and coyote_timer > 0:
		jump_input_timer = 0
		coyote_timer = 0
		jump()
	else:
		if jump_input_timer > 0:
			jump_input_timer -= 1
		if coyote_timer > 0:
			coyote_timer -= 1
	
	if abs(velocity.x) > RUNNING_SPEED:
		velocity.x = max(abs(velocity.x) - CORRECTION_LINEAR_FRICTION, RUNNING_SPEED) * sign(velocity.x)
	
	if abs(velocity.x) < BOOSTING_THRESHOLD:
		if grounded:
			velocity.x *= ground_friction
			velocity.x += direction * ground_acceleration
		else:
			velocity.x *= air_friction
			velocity.x += direction * air_acceleration
	
	if Input.is_action_pressed("ui_accept") and can_shoot and not block_charge:
		charge_timer += 1
		if charge_timer >= OVERCHARGE_TIME:
			gun.shoot(get_parent(), Vector2.RIGHT.rotated(-0.375) * facing, 3)
			gun.shoot(get_parent(), Vector2.RIGHT.rotated(-0.25) * facing, 3)
			gun.shoot(get_parent(), Vector2.RIGHT.rotated(-0.125) * facing, 3)
			gun.shoot(get_parent(), Vector2.RIGHT * facing, 3)
			gun.shoot(get_parent(), Vector2.RIGHT.rotated(0.125) * facing, 3)
			gun.shoot(get_parent(), Vector2.RIGHT.rotated(0.25) * facing, 3)
			gun.shoot(get_parent(), Vector2.RIGHT.rotated(0.375) * facing, 3)
			can_shoot = false
			charge_timer = 0
			velocity.x = -facing * OVERCHARGE_EXPLOSION_BOOST_STRENGTH
			velocity.y = -JUMP_FORCE
			CameraTracker.camera.shake(10)
			emit_signal("charged_shot")
	
	if charge_timer:
		var t = (OVERCHARGE_TIME * 2 - OVERCHARGE_TIME - charge_timer) / float(OVERCHARGE_TIME)
		move_and_slide(
			1.0 / delta * velocity * t * t,
			Vector2.UP
		)
	else:
		move_and_slide(1.0 / delta * velocity, Vector2.UP)
	if is_on_floor():
		velocity.y = 0
		grounded = true
		high_jumping = false
	else:
		grounded = false
	if is_on_ceiling():
		high_jumping = false
		velocity.y = 0
	if is_on_wall():
		if abs(velocity.x) > BOOSTING_THRESHOLD:
			velocity.x = -velocity.x * BOUNCE_MULTIPLIER
		else:
			velocity.x = 0
	
	if direction != 0:
		emit_signal("move")
		facing = direction
	display.scale.x = facing
	if charge_timer:
		animation_player.playback_speed = 0
	else:
		animation_player.playback_speed = abs(velocity.x) * ANIMATION_SPEED_SLOPE + MIN_ANIMATION_SPEED


func jump():
	velocity.y = -JUMP_FORCE
	high_jump_timer = HIGH_JUMP_TIME
	velocity.x *= JUMP_HORIZONTAL_BOOST
	high_jumping = true


func get_hit_but_im_the_player():
	if velocity.x < BOOSTING_THRESHOLD:
		print("you died")
		emit_signal("just_died")
