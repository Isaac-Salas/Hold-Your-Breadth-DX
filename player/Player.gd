extends CharacterBody2D
class_name SlimePlayer

@export var SPEED = 400.0
@export var JUMP_VELOCITY = -400.0
@onready var colision = $CollisionShape2D
@onready var sprite = $Animacion
@export var scalerate = Vector2(0.1, 0.1)
@onready var rigidcolision = $RigidBody2D/CollisionShape2D
@onready var pickup = $Pickup
@onready var object_detect = $ObjectDetect
@onready var currentobj : PickupComponent
@onready var picking = false
@onready var throwing = false
@onready var crosshair = $Pickup/Crosshair


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
		if direction == 1:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
		velocity.x = direction * SPEED
		print(direction)

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		

	
	# Manage grow
	if Input.is_action_pressed("grow"):
		grow()
	# Manage shrink
	if Input.is_action_pressed("shrink"):
		shrink()
		
	#Manage grab
	if Input.is_action_just_pressed("grab") and picking == false:
		grab(currentobj)

	
	if Input.is_action_pressed("throw") and picking == true:
		aim(delta)
	if Input.is_action_just_released("throw") and throwing == true:
		throw(currentobj)
	move_and_slide()
	
	
func grow():
	if SPEED > 100:
		SPEED -= 5
	if colision.scale.x < 3:
		colision.scale += scalerate/2
		rigidcolision.scale += scalerate/2
		sprite.scale += scalerate

func shrink():
	if SPEED < 500 :
		SPEED += 5
	if colision.scale.x > 0.1:
		rigidcolision.scale -= scalerate/2
		colision.scale -= scalerate/2
		sprite.scale -= scalerate

func grab(body):
	if currentobj and picking == false:
		picking = true
		currentobj.reparent(pickup)
		currentobj.freeze = true
		currentobj.colision.disabled = true
		currentobj.global_position = pickup.global_position

func letgo(body):
	if currentobj and picking == true:
		picking = false
		currentobj.reparent(get_tree().get_root())
		currentobj.freeze = false
		currentobj.colision.disabled = false
		currentobj.global_position = pickup.global_position
		

func aim(delta):
	throwing = true
	crosshair.visible = true
	

func throw(body):
	if currentobj and picking == true:
		crosshair.visible = false
		throwing = false
		picking = false
		currentobj.reparent(get_tree().get_root())
		currentobj.freeze = false
		currentobj.colision.disabled = false
		currentobj.global_position = pickup.global_position

func _on_object_detect_body_entered(body):
	if body is PickupComponent and picking == false:
		currentobj = body
		print(body)
