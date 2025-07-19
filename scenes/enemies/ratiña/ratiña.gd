extends RigidBody2D
class_name Rat_enemy

# Exports
@export var speed = 20
@export var climb_force = 60
@export var max_velocity = 300  # Maximum allowed velocity to prevent wall clipping
var ratfleetarget = null
var spawnedfrom = null

# Node references
@onready var sprite = $AnimatedSprite2D
@onready var left_r = $LeftR
@onready var right_r = $RightR
@onready var detector = $Detector
@onready var player_detect = $PlayerDetect
@onready var colision: CollisionShape2D = $CollisionShape2D
@onready var behavior_timer = $BehaviorTimer
@onready var idle_timer = $IdleTimer
@onready var alerted: Sprite2D = $Alerted

# Variables
var player : SlimePlayer
var player_in_vision = false
var idle_direction = 0  # -1 left, 0 wait, 1 right
var idle_wait_counter = 0
var player_memory = "Away"

# Constants
const OUTLINE = preload("res://scenes/objects/Shaders/outline.gdshader")

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	if not player:
		push_error("No player found in scene!")
		return
	_set_new_idle_direction()

func _physics_process(delta):
	if not player or get_parent().is_in_group("barnacle"):
		return
	
	# Cap velocity to prevent going through walls
	_cap_velocity()
	
	if player_in_vision:
		if player.current == "Big":
			_flee_from_player(delta)
		elif player.current == "Small":
			_chase_player(delta)
	elif player_memory != "Away":
		if player_memory == "Big":
			_flee_from_player(delta)
		elif player_memory == "Small":
			_chase_player(delta)
	else:
		_idle_behavior(delta)

func _cap_velocity():
	var current_velocity = linear_velocity
	if current_velocity.length() > max_velocity:
		linear_velocity = current_velocity.normalized() * max_velocity

func _flee_from_player(delta):
	alerted.show()
	sprite.play("new_animation")
	
	var x_direction = sign(global_position.x - player.global_position.x)
	if x_direction == 0:
		x_direction = 1 
	
	var current_x_velocity = linear_velocity.x
	var desired_velocity = x_direction * speed * 100 * delta
	
	if abs(current_x_velocity) < max_velocity or sign(desired_velocity) != sign(current_x_velocity):
		apply_central_impulse(Vector2(desired_velocity, 0))
	
	sprite.flip_h = desired_velocity > 0
	_handle_climbing()

func _chase_player(delta):
	alerted.show()
	sprite.play("new_animation")
	
	var x_direction = sign(player.global_position.x - global_position.x)
	if x_direction == 0:
		x_direction = 1 
	
	var current_x_velocity = linear_velocity.x
	var desired_velocity = x_direction * speed * 100 * delta
	
	if abs(current_x_velocity) < max_velocity or sign(desired_velocity) != sign(current_x_velocity):
		apply_central_impulse(Vector2(desired_velocity, 0))
	
	sprite.flip_h = desired_velocity > 0
	_handle_climbing()

func _idle_behavior(delta):
	alerted.hide()
	sprite.rotation_degrees = 0
	rotation_degrees = 0
	lock_rotation = true
	
	if idle_direction != 0:
		sprite.play("new_animation")
		var movement = idle_direction * speed * 100 * delta

		apply_central_impulse(Vector2(movement, 0))
		
		sprite.flip_h = movement > 0
	else:
		sprite.stop()

func _handle_climbing():
	if left_r.is_colliding() or right_r.is_colliding():
		sprite.rotation_degrees = -90
		# Only climb if not moving too fast vertically
		if linear_velocity.y > -max_velocity * 0.5:
			apply_central_impulse(Vector2(0, -climb_force))
	else:
		sprite.rotation_degrees = 0

func _set_new_idle_direction():
	idle_wait_counter += 1
	if idle_wait_counter >= 2:
		idle_direction = 0 
		idle_wait_counter = 0
	else:
		# Random left or right direction
		idle_direction = randi_range(-1, 1)
		if idle_direction == 0:
			idle_direction = 1

func _on_player_detect_body_entered(body):
	if body.is_in_group("Player"):
		player_in_vision = true
		player = body
		behavior_timer.stop() 

func _on_player_detect_body_exited(body):
	if body.is_in_group("Player"):
		player_memory = body.current
		player_in_vision = false
		behavior_timer.start() 

# Timer signals
func _on_behavior_timer_timeout():
	player_memory = "Away"

func _on_idle_timer_timeout():
	_set_new_idle_direction()
	idle_timer.wait_time = randf_range(0.5, 1.0)
	idle_timer.start()

func _on_detector_area_entered(area):
	if area is ObjectDetect:
		var newmat = ShaderMaterial.new()
		newmat.shader = OUTLINE
		newmat.set_shader_parameter("width", 2)
		newmat.set_shader_parameter("outline_color", Color("ffaa00"))
		sprite.material = newmat

func _on_detector_area_exited(area):
	if area is ObjectDetect:
		sprite.material = null
