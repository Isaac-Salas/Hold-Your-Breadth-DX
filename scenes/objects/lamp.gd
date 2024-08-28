@tool
extends Node2D
@onready var rigid_body_2d : RigidBody2D = $RigidBody2D
@export var color : Color
@onready var point_light_2d = $RigidBody2D/Sprite2D/PointLight2D

# Called when the node enters the scene tree for the first time.
func _ready():
	point_light_2d.color = color


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_rigid_body_2d_body_entered(body):
	if body.is_in_group("throwable"):
		rigid_body_2d.set_deferred("freeze", false)
		rigid_body_2d.add_to_group("throwable")
		
