@tool
extends Area2D
@export var f = 5
@export var img : CompressedTexture2D
@onready var force = Vector2(f,f)
@onready var sprite_2d: Sprite2D = $Sprite2D

var angle
var total_force
func _process(delta: float) -> void:
	sprite_2d.texture = img
	
func _on_body_entered(body: RigidPlayer) -> void:
	print(body)
	angle =  body.global_position - global_position 
	total_force = angle * force
	body.linear_velocity = total_force
	body.look_at(global_position)
	body.rotation -= PI/2
