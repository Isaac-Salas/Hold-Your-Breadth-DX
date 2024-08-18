extends Node2D
class_name Scaler
@onready var icon = $Sprite2D
@onready var factor
@onready var scaler = $"."


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	icon.position.y = clamp(get_local_mouse_position().y, -48, 48)
	factor = -1*((icon.position.y/2)/10)
	icon.scale = Vector2(factor,factor)
	
func reset():
	scaler.global_position = get_global_mouse_position()
