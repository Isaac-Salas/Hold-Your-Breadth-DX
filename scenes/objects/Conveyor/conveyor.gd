extends StaticBody2D
@export var direction = "left"
@export var type = "NORMAL"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var force = Vector2(20,0)
var body : RigidBody2D 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_2d.play(type)
	if direction != "left":
		scale.x = -1

func _physics_process(delta: float) -> void:
	if body:
		body.apply_impulse(force)

func _on_area_2d_body_entered(entered: Node2D) -> void:
	body = entered


func _on_area_2d_body_exited(exited: Node2D) -> void:
	pass # Replace with function body.
