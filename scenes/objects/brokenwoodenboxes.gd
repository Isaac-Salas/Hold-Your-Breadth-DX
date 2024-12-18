extends Node2D
class_name BrokenClass
@export var explodespeed : float
const WALL_BROKEN = preload("res://scenes/objects/Wall_Breakable/Wall_Broken.tres")
var counter : float = 0
var children
var startfree : bool = false
var progress : float
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	children = get_children()
	for i in children:
		if i is RigidBody2D:
			i.set_collision_layer_value(4,true)
			i.set_collision_mask_value(4,true)
	progress = WALL_BROKEN.get_shader_parameter("progress")
	match startfree:
		true:
			counter += explodespeed
			WALL_BROKEN.set("shader_parameter/progress",counter)
			#print(progress)
			if progress > 1.0:
				queue_free()
			
		false:
			pass


func _on_timer_timeout():
		startfree = true
		timer.start()
	
		
