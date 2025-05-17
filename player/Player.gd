extends CharacterBody2D
class_name SlimePlayer

@onready var ragdoll_spawn = $RagdollSpawn
@onready var PLAYERAGDOLL = load("res://player/playeragdoll.tscn")
@onready var defaultmouse = preload("res://assets/placeholder/Tiles/tile_0170.png")
@onready var mousetooltip = preload("res://assets/placeholder/Tiles/tile_0171.png")
@export var THROW_SPEED = 15.0
@export var SPEED = 400.0
@export var JUMP_VELOCITY = -400.0
@onready var colision = $CollisionShape2D
@onready var sprite : AnimatedSprite2D = $Animacion
#@export var scalerate = Vector2(0.1, 0.1)
@onready var rigidcolision = $RigidBody2D/CollisionShape2D
@onready var pickup = $Pickup
@onready var object_detect : Area2D = $AnimatedSprite2D/ObjectDetect
@onready var currentobj
@onready var picking = false
@onready var throwing = false
@onready var scanning = false
@onready var toggle = false
@onready var onarea = false
@onready var crosshair : SwordOrbComponent = $Pickup/Crosshair
@onready var throwcross : SwordOrbComponent = $AnimatedSprite2D

@onready var scaler = $Scaler
@onready var dot = $AnimatedSprite2D
@onready var iscaling = false
const states = ["Small", "Normal", "Big"]
@onready var current = states[1]
signal scare
@onready var tieso = false
@onready var scale_component = $ScaleComponent
@onready var eyes : AnimatedSprite2D = $Animacion/Eyes
@onready var rigid_body = $RigidBody2D
@export var pushstrenght : int = 150


@onready var normallight = $Animacion/Normallight
@onready var small_light = $SmallLight

@onready var controller : bool

signal Movement(value)
signal Jump(value)
signal Throw(value)
signal Grab(value)



func _physics_process(delta):
	#Hard cap whean shrink
	if sprite.scale.x < 0.1:
		rigidcolision.scale = Vector2(0.1,0.1)
		colision.scale = Vector2(0.1,0.1)
		sprite.scale = Vector2(0.1,0.1)

	
	#print(sprite.scale)
	#print(current)
	if sprite.scale.x >= 0.1 and sprite.scale.x <= 0.9:
		SPEED = 600
		JUMP_VELOCITY = -600
		normallight.visible = false
		small_light.visible = true
		current = states[0]
	if sprite.scale.x >= 1 and sprite.scale.x <= 1.9:
		SPEED = 400
		JUMP_VELOCITY = -400
		normallight.visible = true
		small_light.visible = false
		current = states[1]
	if sprite.scale.x >= 2 and sprite.scale.x <= 3:
		dot.radius = 70
		SPEED = 100
		JUMP_VELOCITY = -400
		normallight.visible = true
		small_light.visible = false
		emit_signal("scare")
		current = states[2]
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		Jump.emit(true)
		velocity.y = JUMP_VELOCITY
	elif is_on_floor():
		Jump.emit(false)
	if Input.is_action_just_released("Jump"):
		velocity.y = max(velocity.y, JUMP_VELOCITY/3)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		Movement.emit(true)
		sprite.play("Walk")
		eyes.play("Walked")
		if direction == 1:
			eyes.flip_h = false
			sprite.flip_h = false
			rigid_body.linear_velocity.x = pushstrenght 
			
		else:
			eyes.flip_h = true
			sprite.flip_h = true
			rigid_body.linear_velocity.x = -pushstrenght 
		velocity.x = direction * SPEED
		#print(direction)

	else:
		Movement.emit(false)
		sprite.play("Idle")
		eyes.play("Idle")
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
		#print("stopping")
	
	# Manage grow
	#if Input.is_action_pressed("grow"):
		#grow()
	## Manage shrink
	#if Input.is_action_pressed("shrink"):
		#shrink()
	
	# Manage grab
	if Input.is_action_just_pressed("LefMouse") and picking == false and scanning == false and toggle == false:
		object_detect.monitoring = true
		scanning = true

	if Input.is_action_just_released("LefMouse") and picking == false and scanning == true and toggle == false:
		scanning = false
		var success = grab(currentobj)
		if not success:
			object_detect.monitoring = true 
		else:
			object_detect.monitoring = false
			object_detect.monitorable = false

	# Manage throwing
	if Input.is_action_pressed("RightMouse") and picking == true:
		aim(delta)

	if Input.is_action_just_released("RightMouse") and throwing == true:
		throw(currentobj)
		object_detect.monitorable = true

	if tieso == false:
		move_and_slide()
	
func get_hit(canrevive : bool):
	self.queue_free()
	ragdoll_spawn.scene = PLAYERAGDOLL
	var dead : RigidPlayer = ragdoll_spawn.spawn()
	if canrevive == true:
		dead.revived()
	else:
		pass
	
	return dead


func togglefun():
	if toggle == false:
		toggle = true
		
		dot.visible = false
		
	else:
		toggle = false
		
		dot.visible = true

func scaling():
	#print(sprite.scale)
	iscaling = true
	var thing = Vector2(scaler.factor/10,scaler.factor/10)*50
	if thing > Vector2(0,0):
		grow(thing)
	else:
		shrink(-thing)
	

func grow(scalerate):
	if sprite.scale.x + scalerate.x < 3:
		colision.scale = sprite.scale
		rigidcolision.scale += scalerate
		sprite.scale += scalerate
		position.y -= scalerate.y * 30
	else:
		rigidcolision.scale = Vector2(3,3)
		colision.scale = sprite.scale
		sprite.scale = Vector2(3,3)

func shrink(scalerate):
	if sprite.scale.x - scalerate.x > 0.1:
		rigidcolision.scale -= scalerate
		colision.scale = sprite.scale
		sprite.scale -= scalerate
	else:
		rigidcolision.scale = Vector2(0.1,0.1)
		colision.scale = sprite.scale
		sprite.scale = Vector2(0.1,0.1)

func grab(body):
	if body != null and picking == false and body.sprite.scale <= sprite.scale or body != null and picking == false and body is Rat_enemy :
		Grab.emit(true)
		if body.is_in_group("Matraz"):
			body.break_after_throw = true
		$AnimatedSprite2D.visible = false
		picking = true
		body.reparent(pickup)
		body.freeze = true
		body.colision.disabled = true
		#currentobj.collision.layer = 8
		body.global_position = pickup.global_position
		
		return true
	return false
#func letgo(body):
	#if currentobj and picking == true:
		#picking = false
		#var repar = get_tree().current_scene
		#
		#print(repar)
		#currentobj.reparent(repar, false)
		#print_orphan_nodes() 
		#print_tree()
		#currentobj.freeze = false
		#currentobj.colision.disabled = false
		#currentobj.global_position = pickup.global_position
		

func aim(delta):
	throwing = true
	crosshair.visible = true
	throwcross.overridevisible = true
	
	

func throw(body):
	if currentobj and picking == true:
		Throw.emit(true)
		$AnimatedSprite2D.visible = true
		if currentobj.is_in_group("Meatbox"):
			currentobj.picked = true
		crosshair.visible = false
		throwing = false
		picking = false
		currentobj.linear_velocity = crosshair.VelVec * THROW_SPEED
		currentobj.angular_velocity = 20.0
		currentobj.reparent(get_tree().current_scene)
		currentobj.freeze = false
		currentobj.colision.disabled = false
		currentobj.global_position = pickup.global_position
		currentobj = null
		throwcross.overridevisible = false
		#print(currentobj)
		
func set_size(target_size):
	colision.scale = target_size/2
	rigidcolision.scale = target_size/2
	sprite.scale = target_size/2
	if currentobj and picking == true and !currentobj.is_in_group("Meatbox") and !currentobj.is_in_group("edible"):
		currentobj.set_size(target_size)

func _on_object_detect_body_entered(body):
	if body.is_in_group("throwable") and picking == false:
		currentobj = body
