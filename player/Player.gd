extends CharacterBody2D


@export var SPEED = 400.0
@export var JUMP_VELOCITY = -400.0
@onready var colision = $CollisionShape2D
@onready var sprite = $Animacion
@export var scalerate = Vector2(0.1, 0.1)



func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	
	# Manage grow
	if Input.is_action_pressed("grow"):
		grow()
	# Manage shrink
	if Input.is_action_pressed("shrink"):
		shrink()

	move_and_slide()
	
	
func grow():
	if SPEED > 100:
		SPEED -= 5
	colision.scale += scalerate/2
	sprite.scale += scalerate

func shrink():
	if SPEED < 500 :
		SPEED += 5
	if colision.scale.x > 0.1:
		colision.scale -= scalerate/2
		sprite.scale -= scalerate
