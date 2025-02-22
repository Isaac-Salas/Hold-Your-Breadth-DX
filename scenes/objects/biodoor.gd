extends StaticBody2D
@onready var ap: AnimationPlayer = $AnimationPlayer
@onready var as2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var eye_1 = $Eye1
@onready var eye_2 = $Eye2
@export var radius = 8
@export var factor = 1
@onready var looking : bool = false
@onready var player : SlimePlayer
@onready var anchor_1 = $Anchor1
@onready var anchor_2 = $Anchor2
@onready var licktimer = $Licktimer
@onready var openm : bool = false
@onready var coll = $CollisionShape2D
@onready var start_looking = $StartLooking
@onready var open_mouth = $OpenMouth
@onready var done = false
@onready var chewcounter : int = 3
@export var lick_override : bool = false
@onready var keyhole = $Keyhole

func _ready():
	if lick_override == true:
		licktimer.wait_time = 1
		licktimer.start()
	else:
		licktimer.wait_time = randf_range(3,20)
		licktimer.start()
	as2d.play("default")

	
func _on_keyhole_body_entered(body: Node2D) -> void:
	if body.is_in_group("rigidbarnacle"):
		done = true
		body.queue_free()
		open_mouth.queue_free()
		start_looking.queue_free()
		keyhole.queue_free()
		for i in chewcounter:
			as2d.play("Chew")
			await as2d.animation_finished
		as2d.play("Done")
		#ap.play("OPEN")
		await(as2d.animation_finished)
		coll.queue_free()
		
	elif body.is_in_group("breakable"):
		body.destroy()
		for i in chewcounter:
			as2d.play("Mock")
			await as2d.animation_finished
		as2d.play("default")
		await(as2d.animation_finished)
		
	elif body is SlimePlayer:
		var dead : RigidPlayer = body.get_hit(true)
		#print(dead.canrevive)
		dead.apply_impulse(Vector2(-200,-100))
		for i in chewcounter:
			as2d.play("Mock")
			await as2d.animation_finished
		as2d.play("default")
		await(as2d.animation_finished)
		#print(dead.canrevive)
		#body.ragdoll_spawn

func _physics_process(delta):
	match looking:
		true:
			follow(anchor_1,player,eye_1,delta)
			follow(anchor_2, player,eye_2,delta)
		false:
			eye_1.position = anchor_1.position 
			eye_2.position = anchor_2.position 
			
	if as2d.animation == "Done" and as2d.frame == 3:
		eye_1.visible = false
		eye_2.visible = false


func follow (anchor : Marker2D, target : CharacterBody2D, movingbody : Sprite2D, delta):
	

		#print("Show")
	var mouse_pos = target.global_position
	var player_pos = anchor.global_transform.origin 
	var distance = player_pos.distance_to(mouse_pos) 
	#var stick = Input.get_joy_axis(0,)
	var mouse_dir = (mouse_pos-player_pos).normalized()
	if distance > radius:
		mouse_pos = player_pos + (mouse_dir * radius)
	movingbody.global_transform.origin = mouse_pos


func _on_start_looking_body_entered(body):
	if body is SlimePlayer:
		player = body
		looking = true


func _on_start_looking_body_exited(body):
	if body is SlimePlayer:
		player = body
		looking = false


func _on_open_mouth_body_entered(body):
	if body.is_in_group("button_actionable") or body is SlimePlayer:
		if done == false:
			as2d.play("MouthOpen")
			openm = true


func _on_open_mouth_body_exited(body):
	if body.is_in_group("button_actionable") or body is SlimePlayer:
		if done == false:
			as2d.play_backwards("MouthOpen")
			await as2d.animation_finished
			as2d.play("default")
			openm = false


func _on_licktimer_timeout():
	if openm == false and done == false:
		as2d.play("Lick")
		await as2d.animation_finished
		as2d.play("default")
		
	licktimer.wait_time = randf_range(3,20)
	licktimer.start()
	
