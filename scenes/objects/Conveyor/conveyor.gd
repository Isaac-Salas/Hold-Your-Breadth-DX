extends StaticBody2D
@export_enum("left", "right") var direction = "left"
@export_enum("LEFT", "NORMAL", "RIGHT") var type = "NORMAL"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var force 
@onready var area_2d: Area2D = $Area2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var inside : Array[RigidBody2D] = []
@export var isOFF = false
func _ready() -> void:
	toggle(isOFF, 0)
	if (direction == "left"):
		force = Vector2(-20,-15)
	else:
		force =  Vector2(20,-15)
	animated_sprite_2d.play(type)
	if direction != "left":
		scale.x = -1

func _physics_process(delta: float) -> void:
	for body in inside:
		if abs(body.linear_velocity.x) < abs(force.x) * 15:
			#print(body.linear_velocity)
			body.apply_impulse(force)
			body.apply_torque(30)

func _on_area_2d_body_entered(entered: Node2D) -> void:
	inside.append(entered)
	#print(inside.size())
	#print(entered.name)

func _on_area_2d_body_exited(exited: Node2D) -> void:
	inside.remove_at(inside.find(exited))

func toggle(state, body):
	isOFF = !isOFF
	if isOFF:
		sprite.play()
		if body != 0:
			await(get_tree().create_timer(0.5).timeout)
		area_2d.monitoring = true
	else:
		if body != 0:
			await(get_tree().create_timer(1).timeout)
		sprite.stop()
		area_2d.monitoring = false
