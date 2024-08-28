extends Node2D
const PLAYERAGDOLL = preload("res://player/playeragdoll.tscn")
const PLAYER = preload("res://player/player.tscn")
const BARNACLE = preload("res://scenes/enemies/barnacle.tscn")
const RIGIDBARNACLE = preload("res://scenes/enemies/Barnacle/rigidbarnacle.tscn")
@onready var colliders : Node2D
@onready var rigid_body_2d = $rigids/RigidBody2D
@onready var firstone = $rigids/RigidBody2D
@onready var sprite_2d_2 = $Sprite2D2

@onready var animation_player = $AnimationPlayer


@onready var lastone = $rigids/RigidBody2D8
@onready var spawner_component = $rigids/RigidBody2D8/SpawnerComponent
@onready var joint = $PinJoint2D9
@onready var marker_2d = $rigids/RigidBody2D8/Marker2D
@onready var rigids = $rigids

@onready var firstjoint = $PinJoint2D
@onready var static_body_2d = $StaticBody2D
@onready var killer = $Killer
@onready var area_2d = $rigids/RigidBody2D8/Area2D
@onready var timer = $Timer
@onready var spawned
@onready var regen = false
@onready var done = false


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_2d_2.play("default")
	sprite_2d_2.animation_finished.connect(start)
	for i in rigids.get_children():
		var deact = i.find_child("CollisionShape2D")
		deact.set_deferred("disabled", true)
	area_2d.set_deferred("monitoring", false)
		

func start():
	rigids.set_deferred("visible", true)
	animation_player.play("new_animation")
	for i in rigids.get_children():
		var deact = i.find_child("CollisionShape2D")
		deact.set_deferred("disabled", false)
	area_2d.set_deferred("monitoring", true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if colliders:
		if lastone.visible == false and colliders.is_in_group("edible"):
			self.queue_free()
			spawner_component.scene = RIGIDBARNACLE
			var new = spawner_component.spawn()
			new.global_position= self.global_position
			
			
		if lastone.visible == false and colliders.is_in_group("breakable"):
			if colliders.spawner_component.scene:
				colliders.destroy()
			sprite_2d_2.stop()
			#print("Spit")
			done = true
			if static_body_2d.position.y < 0 and regen == true:
				if firstone.visible == false:
					spawner_component.scene = BARNACLE
					self.queue_free()
					var new = spawner_component.spawn()
					new.global_position = self.global_position
				
		

		
		
	#	colliders.set_deferred("freeze", false)
	if colliders:
		if joint.node_b:
			if static_body_2d.position.y > -400 and done == false:
				static_body_2d.position.y -= randf_range(0.1,2)

				
			
				#i.find_child("CollisionShape2D").set_deferred("disabled", true)
				#i.set_deferred("freeze", true)
				#i.global_position -= Vector2(0,0.1)
		
	



func _on_area_2d_body_entered(body):
	
	colliders = body
	#print(colliders)
	if colliders.is_in_group("Player"):
		sprite_2d_2.play("new_animation")
		area_2d.set_deferred("monitoring", false)
		lastone.apply_impulse(colliders.velocity)
		colliders.queue_free()
		spawner_component.scene = PLAYERAGDOLL
		spawned = spawner_component.spawn()
		#print(spawned)
		spawned.set_deferred("freeze", true)
		colliders.colision.set_deferred("disabled", true)
		spawned.global_position = lastone.global_position
		#colliders.reparent(lastone)
		spawned.call_deferred("reparent",lastone)
		timer.start(2)
		
		
				#joint.node_b = colliders.get_path()
		
		#olliders.set_deferred("visible", false)

	if colliders.is_in_group("edible"):
		sprite_2d_2.play("new_animation")
		killer.set_deferred("monitoring", true)
		area_2d.set_deferred("monitoring", false)
		colliders.set_deferred("freeze", true)
		lastone.apply_impulse(colliders.linear_velocity)
		colliders.set_collision_layer_value(2,false)
		colliders.set_collision_mask_value(2,false)
		#colliders.reparent(lastone)
		colliders.call_deferred("reparent",lastone)
		colliders.global_position = lastone.global_position
		joint.node_b = colliders.get_path()
		#colliders.remove_from_group("edible")
		
	if colliders.is_in_group("breakable"):
		sprite_2d_2.play("new_animation")
		regen = true
		killer.set_deferred("monitoring", true)
		area_2d.set_deferred("monitoring", false)
		colliders.set_deferred("freeze", true)
		lastone.apply_impulse(colliders.linear_velocity)
		colliders.set_collision_layer_value(2,false)
		colliders.set_collision_mask_value(2,false)
		#colliders.reparent(lastone)
		colliders.call_deferred("reparent",lastone)
		colliders.global_position = lastone.global_position
		joint.node_b = colliders.get_path()
		#colliders.remove_from_group("breakable")


func _on_killer_body_entered(body):
	#print(body)
	if body.is_in_group("piece"):
		body.set_deferred("visible", false)
	if body.is_in_group("piece") and body.visible == false:
		body.set_deferred("visible", true)

		


func _on_timer_timeout():
	sprite_2d_2.stop()
	#print("throw")
	spawned.set_deferred("freeze", false)
	spawned.call_deferred("reparent",self.get_parent())
	area_2d.set_deferred("monitoring", true)
	lastone.linear_velocity += Vector2(-400,0)
	spawned.linear_velocity += Vector2(-400,0)
	spawned.angular_velocity += 30

	spawned.revived()
