extends RigidBody2D
class_name Slide
@onready var slide_sprite: Sprite2D = $SlideSprite

@export var dropped : bool = false

func _ready() -> void:
	if dropped == true:
		drop()

func drop():
	dropped = true
	self.set_deferred("freeze", false)
	self.modulate = Color("3c3c3c")
	self.angular_velocity = randf_range(-10,10)
	
