extends Node2D

@export var paddle_strength: float = 20.0
@export var return_strength: float = 5.0
@export var max_rotation: float = 45.0  # in degrees
@export var activation_key: String = "ui_accept"
@export var rest_position: float = 0.0  # in degrees
@export var paddle_mass: float = 2.0

@onready var paddle: RigidBody2D = $Paddle
@onready var pivot: Node2D = $Pivot
@onready var rest_joint: PinJoint2D = $RestJoint
@onready var limit_joint: PinJoint2D = $LimitJoint

var is_activated: bool = false
var original_rotation: float
var target_rotation: float

func _ready():
	# Set up the paddle
	original_rotation = deg_to_rad(rest_position)
	target_rotation = original_rotation
	
	# Configure the paddle's physics properties
	paddle.mass = paddle_mass
	paddle.gravity_scale = 0.0  # Disable gravity effect
	paddle.lock_rotation = false
	paddle.can_sleep = false
	
	# Set up joints
	rest_joint.node_a = pivot.get_path()
	rest_joint.node_b = paddle.get_path()
	
	limit_joint.node_a = pivot.get_path()
	limit_joint.node_b = paddle.get_path()
	
	# Configure the angular limits
	
	var limit_shape = Joint2D.new()
	limit_shape.set_angle_limit(deg_to_rad(-max_rotation), deg_to_rad(max_rotation))
	limit_joint.set_joint_shape(limit_shape)

func _physics_process(delta):
	if Input.is_action_just_pressed(activation_key):
		activate_paddle()
	elif Input.is_action_just_released(activation_key):
		release_paddle()
	
	# Apply return force when not activated
	if !is_activated:
		apply_return_force(delta)

func activate_paddle():
	is_activated = true
	target_rotation = deg_to_rad(rest_position + max_rotation)
	
	# Apply the impulse to the paddle
	var impulse_force = paddle_strength
	var impulse_vector = Vector2(0, -impulse_force).rotated(paddle.global_rotation)
	paddle.apply_impulse(impulse_vector, paddle.position - pivot.position)

func release_paddle():
	is_activated = false
	target_rotation = original_rotation

func apply_return_force(delta):
	# Apply a gentle return force to bring the paddle back to rest position
	var current_angle = paddle.rotation
	var angle_diff = target_rotation - current_angle
	
	if abs(angle_diff) > 0.01:
		var return_force = return_strength * angle_diff
		paddle.apply_torque(return_force)

# Alternative implementation using a hinge joint (more stable in some cases)
func setup_with_hinge_joint():
	# Remove existing joints if present
	if rest_joint:
		rest_joint.queue_free()
	if limit_joint:
		limit_joint.queue_free()
	
	# Create hinge joint
	var hinge = HingeJoint2D.new()
	add_child(hinge)
	hinge.node_a = pivot.get_path()
	hinge.node_b = paddle.get_path()
	
	# Configure limits
	hinge.angular_limit_enabled = true
	hinge.angular_limit_lower = deg_to_rad(-max_rotation)
	hinge.angular_limit_upper = deg_to_rad(0)  # Assuming 0 is the rest position
	
	# Configure other parameters
	hinge.bias = 0.5  # Controls how strictly the limits are enforced
	hinge.softness = 0.1  # Lower value = stiffer joint
	hinge.relaxation = 0.4  # Higher value = more damping
