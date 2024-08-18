extends Node2D
@onready var colliders
@onready var lastone = $rigids/RigidBody2D8

@onready var joint = $PinJoint2D9
@onready var marker_2d = $rigids/RigidBody2D8/Marker2D
@onready var rigids = $rigids
@onready var firstjoint = $PinJoint2D
@onready var static_body_2d = $StaticBody2D
@onready var killer = $Killer
@onready var area_2d = $rigids/RigidBody2D8/Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if lastone.visible == false:
		queue_free()
	#	colliders.set_deferred("freeze", false)
	if colliders:
		if joint.node_b:
			static_body_2d.global_position.y -= randf_range(0.1,1)
				#i.find_child("CollisionShape2D").set_deferred("disabled", true)
				#i.set_deferred("freeze", true)
				#i.global_position -= Vector2(0,0.1)
		
	


func _on_area_2d_body_entered(body):
	colliders = body
	if colliders.is_in_group("Player"):
		pass

	if colliders.is_in_group("edible"):
		area_2d.set_deferred("monitoring", false)
		colliders.set_deferred("freeze", true)
		lastone.apply_impulse(colliders.linear_velocity)
		colliders.colision.set_deferred("disabled", true)
		#colliders.reparent(lastone)
		colliders.call_deferred("reparent",lastone)
		colliders.global_position = lastone.global_position
		joint.node_b = colliders.get_path()
		colliders.remove_from_group("edible")


func _on_killer_body_entered(body):
	print(body)
	if body.is_in_group("piece"):
		body.set_deferred("visible", false)
