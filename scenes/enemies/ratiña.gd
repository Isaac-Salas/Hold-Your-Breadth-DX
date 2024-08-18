extends RigidBody2D
@onready var timer = $Timer
@onready var target_loc = $TargetLoc
@onready var direction
@export var speed = 0
@onready var timer_2 = $Timer2
@onready var player : SlimePlayer
@onready var playerdir
@onready var sprite = $AnimatedSprite2D
@onready var timer_3 = $Timer3
@onready var fleeonce = false
@onready var colision = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	
	direction = global_position - target_loc.global_position
	chillin()
	player = get_tree().get_first_node_in_group("Player")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if get_parent().is_in_group("barnacle"):
		var count = 0
		match count:
			0:
				if timer and timer_2 and timer_3:
					timer.stop()
					timer_2.stop()
					timer_3.stop()
				count += 1
			1:
				pass
	
		
	direction = global_position - target_loc.global_position
	
	

func chillin():
	timer_3.stop()
	timer_2.stop()
	rotation = 0
	set_deferred("lock_rotation", true)
	timer.start(randf_range(0.1,1))
	target_loc.position.x = randi_range(-50,50)
	apply_central_impulse(direction*speed)

func chasing(player):
	timer.stop()
	timer_3.stop()
	set_deferred("lock_rotation", false)
	timer_2.start(0.25)
	playerdir = player.global_position - global_position
	apply_central_impulse(Vector2(playerdir.x*3, playerdir.y))

func fleeing():
	timer.stop()
	timer_2.stop()
	print("Ratflee")
	var fleeingdir = global_position - player.global_position
	apply_central_impulse(Vector2(fleeingdir.x*4,-20))
	timer_3.start(0.5)

	

func _on_timer_timeout():
	chillin()
	


func _on_player_detect_body_entered(body):
	if body.is_in_group("Player"):
		if player.current == "Big":
			print("Naceobesa")
			fleeing()
		player.scare.connect(fleeing)
		#timer.stop()
		player = body
		chasing(player)


func _on_timer_2_timeout():
	chasing(player)


func _on_player_detect_body_exited(body):
	if body.is_in_group("Player"):
		player.scare.disconnect(fleeing)
		timer_2.stop()
		timer_3.stop()
		fleeonce = false
		chillin()


func _on_timer_3_timeout():
	fleeing()
	
