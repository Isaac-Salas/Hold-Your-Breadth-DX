extends CharacterBody2D
class_name SlimePlayer

@onready var defaultmouse = preload("res://assets/placeholder/Tiles/tile_0170.png")
@onready var mousetooltip = preload("res://assets/placeholder/Tiles/tile_0171.png")
@export var THROW_SPEED = 15.0
@export var SPEED = 400.0
@export var JUMP_VELOCITY = -400.0
@onready var colision = $CollisionShape2D
@onready var sprite = $Animacion
#@export var scalerate = Vector2(0.1, 0.1)
@onready var rigidcolision = $RigidBody2D/CollisionShape2D
@onready var pickup = $Pickup
@onready var object_detect = $AnimatedSprite2D/ObjectDetect
@onready var currentobj
@onready var picking = false
@onready var throwing = false
@onready var scanning = false
@onready var toggle = false
@onready var onarea = false
@onready var crosshair = $Pickup/Crosshair
@onready var scaler = $Scaler
@onready var dot = $AnimatedSprite2D
@onready var iscaling = false
const states = ["Small", "Normal", "Big"]
@onready var current = states[1]
signal scare


func _physics_process(delta):
	
	#print(current)
	if sprite.scale.x >= 0.1 and sprite.scale.x <= 1.9:
		if sprite.scale.x < 0.1:
			sprite.scale.x == 0.1
		current = states[0]
	if sprite.scale.x >= 2 and sprite.scale.x <= 3.9:
		current = states[1]
	if sprite.scale.x >= 4 and sprite.scale.x <= 6:
		emit_signal("scare")
		if sprite.scale.x > 6:
			sprite.scale.x == 6
		current = states[2]
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
		sprite.play("Walk")
		if direction == 1:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
		velocity.x = direction * SPEED
		#print(direction)

	else:
		sprite.play("Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	
	if Input.is_action_just_pressed("Toogle"):
		togglefun()
		
	
	if Input.is_action_just_pressed("LefMouse") and picking == false and toggle == true:
		scaler.visible = true
		scaler.reset()
	
	if Input.is_action_pressed("LefMouse") and picking == false and toggle == true:
		#scaler.reset()
		scaling()
	
	if Input.is_action_just_released("LefMouse") and picking == false and toggle == true:
		scaler.visible = false
		print("stopping")
	
	# Manage grow
	#if Input.is_action_pressed("grow"):
		#grow()
	## Manage shrink
	#if Input.is_action_pressed("shrink"):
		#shrink()
		
	#Manage grab
	if Input.is_action_just_pressed("LefMouse") and picking == false and scanning == false and toggle == false:
		object_detect.monitoring = true
		scanning = true
	
	if Input.is_action_just_released("LefMouse") and picking == false and scanning == true and toggle == false:
		object_detect.monitoring = false
		object_detect.monitorable = false
		scanning = false
		grab(currentobj)
	
	if Input.is_action_pressed("RightMouse") and picking == true:
		aim(delta)
	if Input.is_action_just_released("RightMouse") and throwing == true:
		throw(currentobj)
		object_detect.monitorable = true
	move_and_slide()
	
func togglefun():
	if toggle == false:
		toggle = true
		Input.set_custom_mouse_cursor(mousetooltip)
		dot.visible = false
		
	else:
		toggle = false
		Input.set_custom_mouse_cursor(defaultmouse)
		dot.visible = true

func scaling():
	print(sprite.scale)
	iscaling = true
	var thing = Vector2(scaler.factor/10,scaler.factor/10)
	if thing > Vector2(0,0):
		grow(thing)
	else:
		shrink(-thing)
	

func grow(scalerate):
	if SPEED > 100:
		SPEED -= 5
	if colision.scale.x < 3:
		colision.scale += scalerate/2
		rigidcolision.scale += scalerate/2
		sprite.scale += scalerate

func shrink(scalerate):
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
		currentobj.linear_velocity = crosshair.VelVec * THROW_SPEED
		currentobj.angular_velocity = 20.0
		currentobj.reparent(get_tree().get_root())
		currentobj.freeze = false
		currentobj.colision.disabled = false
		currentobj.global_position = pickup.global_position
		currentobj = null
		print(currentobj)

func _on_object_detect_body_entered(body):
	if body.is_in_group("throwable") and picking == false:
		currentobj = body
		#print(currentobj)
