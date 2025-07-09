extends RayCast2D

signal hit_detected(body)
@onready var crosshair: AnimatedSprite2D = $Crosshair
@export var radius := 50
@export var factor := 1
@export var player: SlimePlayer
@export var debug_controller := false
var collision_point = Vector2.ZERO
var previous_collider = null
var status = 'look'
@onready var pickup: Marker2D = $"../Pickup"



var VelVec := Vector2.ZERO

func _ready():
	if debug_controller:
		Input.joy_connection_changed.connect(_on_joy_connection_changed)


func _process(delta):
	if player == null:
		return
	var mouse_pos = get_global_mouse_position()
	var aimcontroller = Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
	var using_controller = Input.get_connected_joypads().size() > 0

	var direction := Vector2.ZERO
	
	
	if using_controller and aimcontroller != Vector2.ZERO:
		player.controller = true
		direction = aimcontroller.normalized() 
	else:
		player.controller = false
		direction = (mouse_pos - global_position).normalized()
	
	target_position = direction * radius
	
	match status:
		'grab':
			crosshair.hide()
			crosshair.play("default")
		'aim':
			crosshair.show()
			position.y = pickup.position.y
			if crosshair.animation != 'throw':
				crosshair.play("throw")
			previous_collider = null
			if is_colliding():
				var collider = get_collider()
				collision_point = get_collision_point()
			else:
				collision_point = target_position + global_position
		'look':
			if using_controller and aimcontroller == Vector2.ZERO:
				crosshair.hide()
			else:
				crosshair.show()
			position.y = 0
			if is_colliding():
				var collider = get_collider()
				collision_point = get_collision_point()
				if previous_collider != collider:
					previous_collider = collider
					if collider.is_in_group("throwable"):
						emit_signal("hit_detected", collider)
						crosshair.play("grab?")
					else:
						crosshair.play("default")
			else:
				previous_collider = null
				collision_point = target_position + global_position
				crosshair.play("default")
	
	crosshair.global_position = collision_point
	VelVec = Vector2(collision_point - global_position)


func _on_joy_connection_changed(device: int, connected: bool):
	print("Controller connection changed. Joypads now:", Input.get_connected_joypads())
