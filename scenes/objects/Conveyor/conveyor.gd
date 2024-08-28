extends StaticBody2D
@export_enum("left", "right") var direction = "left"
@export_enum("LEFT", "NORMAL", "RIGHT") var type = "NORMAL"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var force 
var inside : Array[RigidBody2D] = []

func _ready() -> void:
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
			print(body.linear_velocity)
			body.apply_impulse(force)
			body.apply_torque(30)

func _on_area_2d_body_entered(entered: Node2D) -> void:
	inside.append(entered)
	print(inside.size())
	print(entered.name)


func _on_area_2d_body_exited(exited: Node2D) -> void:
	inside.remove_at(inside.find(exited))
