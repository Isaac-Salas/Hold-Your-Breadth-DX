extends RigidBody2D
class_name Rat_enemy

@export var flee_target: Marker2D
@export var idle_speed: float = 10.0
@export var chase_speed: float = 3.0
@export var flee_speed: float = 5.0
@export var flee_from_player: bool = false  # Toggle: true = flee from player, false = flee to marker

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var colision: CollisionShape2D = $CollisionShape2D
@onready var alerted: Node = $Alerted
@onready var left_ray: RayCast2D = $LeftR
@onready var right_ray: RayCast2D = $RightR
@onready var detector: Area2D = $Detector
@onready var target_loc: Marker2D = $TargetLoc
@onready var idle_timer: Timer = $Timer
@onready var chase_timer: Timer = $Timer2
@onready var state_timer: Timer = $Timer3

var player: SlimePlayer
var spawned_from: RatSpawn
var direction: Vector2
var is_moving: bool = false  # Track if the rat is currently moving

# Constants
const OUTLINE = preload("res://scenes/objects/Shaders/outline.gdshader")
const CLIMB_IMPULSE = -50
const OUTLINE_WIDTH = 2
const OUTLINE_COLOR = Color("ffaa00")
const FLEE_DISTANCE = 250.0
const MOVEMENT_THRESHOLD = 5.0

# State management
enum State { IDLE, CHASING, FLEEING }
var current_state: State = State.IDLE
var distance_to_player: float = 10000

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	_connect_player_signals()
	_change_state(State.IDLE)

func _physics_process(delta):
	if not player:
		_update_player_reference()
	_handle_current_state(delta)
	_handle_climbing()

func _update_player_reference():
	player = get_tree().get_first_node_in_group("Player")
	if player and not player.scare.is_connected(_on_player_scare):
		_connect_player_signals()

func _handle_current_state(delta):
	match current_state:
		State.IDLE:
			_handle_idle_state(delta)
		State.CHASING:
			_handle_chase_state(delta)
		State.FLEEING:
			_handle_flee_state(delta)

func _handle_idle_state(delta):
	alerted.visible = false
	sprite.play("new_animation")
	
	if is_moving:
		# Move toward target_loc
		direction = (target_loc.global_position - global_position).normalized()
		apply_central_impulse(direction * idle_speed)
		if direction.x > 0:
			sprite.flip_h = true
		if direction.x < 0:
			sprite.flip_h = false
		# Check if close to target
		if global_position.distance_to(target_loc.global_position) < MOVEMENT_THRESHOLD:
			is_moving = false
			sprite.stop()  # Pause animation while waiting
			idle_timer.start(randf_range(0.5, 2.0))  # Wait before picking new target

func chillin():
	rotation = 0
	set_deferred("lock_rotation", true)
	target_loc.position.x = randf_range(-20, 20)
	is_moving = true  # Start moving to new target

func _handle_chase_state(delta):
	if not player:
		_change_state(State.IDLE)
		return
	sprite.play("chase")
	alerted.visible = true
	var direction = (player.global_position - global_position).normalized()
	apply_central_impulse(direction * chase_speed)
	_update_sprite_direction(direction)

func _handle_flee_state(delta):
	if not player:
		_change_state(State.IDLE)
		return
	sprite.play("flee")
	alerted.visible = true
	var direction: Vector2
	var reached_safety = false
	if flee_from_player and player:
		direction = (global_position - player.global_position).normalized()
		distance_to_player = global_position.distance_to(player.global_position)
		reached_safety = distance_to_player > FLEE_DISTANCE or player.current != "Big"
	elif flee_target:
		direction = (flee_target.global_position - global_position).normalized()
		var distance_to_target = global_position.distance_to(flee_target.global_position)
		reached_safety = distance_to_target < MOVEMENT_THRESHOLD
	else:
		_change_state(State.IDLE)
		return
	apply_central_impulse(direction * flee_speed)
	_update_sprite_direction(direction)
	if reached_safety:
		_change_state(State.IDLE)

func _handle_climbing():
	if left_ray.is_colliding() or right_ray.is_colliding():
		apply_central_impulse(Vector2(0, CLIMB_IMPULSE))
		sprite.rotation_degrees = -90
	else:
		if current_state != State.IDLE:
			sprite.rotation_degrees = 0

func _update_sprite_direction(direction: Vector2):
	sprite.flip_h = direction.x > 0

func _change_state(new_state: State):
	if current_state == new_state:
		return
	_exit_current_state()
	current_state = new_state
	_enter_new_state()

func _exit_current_state():
	idle_timer.stop()
	chase_timer.stop()
	state_timer.stop()
	set_deferred("lock_rotation", false)
	is_moving = false

func _enter_new_state():
	match current_state:
		State.IDLE:
			_setup_idle_state()
		State.CHASING:
			_setup_chase_state()
		State.FLEEING:
			_setup_flee_state()

func _setup_idle_state():
	set_deferred("lock_rotation", true)
	chillin()

func _setup_chase_state():
	chase_timer.start(0.1)

func _setup_flee_state():
	pass

func _connect_player_signals():
	if player and not player.scare.is_connected(_on_player_scare):
		player.scare.connect(_on_player_scare)

func _on_player_scare():
	if distance_to_player < FLEE_DISTANCE:
		_change_state(State.FLEEING)

func _on_timer_timeout():
	chillin()

func _on_timer_2_timeout():
	pass

func _on_timer_3_timeout():
	pass

func _on_player_detect_body_entered(body):
	if not body.is_in_group("Player"):
		return
	player = body
	_connect_player_signals()
	if player.current == "Big":
		_change_state(State.FLEEING)
	else:
		_change_state(State.CHASING)

func _on_player_detect_body_exited(body):
	if body.is_in_group("Player"):
		player = null
		_change_state(State.IDLE)

func _on_detector_area_entered(area):
	if area is ObjectDetect:
		_apply_highlight()

func _on_detector_area_exited(area):
	if area is ObjectDetect:
		_remove_highlight()

func _apply_highlight():
	var shader_material = ShaderMaterial.new()
	shader_material.shader = OUTLINE
	shader_material.set_shader_parameter("width", OUTLINE_WIDTH)
	shader_material.set_shader_parameter("outline_color", OUTLINE_COLOR)
	sprite.material = shader_material

func _remove_highlight():
	sprite.material = null
