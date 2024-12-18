extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var area_2d = $Area2D

@onready var sprite = $AnimatedSprite2D
@onready var player : Node2D
@onready var timer = $Timer
@export var speed = 0.01
@export var dialog : DialogComponent
@onready var handstate : int = 0
@onready var initpos
@onready var triggered = false
var motion : Vector2
var gravity2 : Vector2
var targetx : float
@onready var hit_cooldown = $Hit_cooldown



# Called when the node enters the scene tree for the first time.
func _ready():
	initpos = global_position
	player = get_tree().get_first_node_in_group("Player")
	sprite.play("Idle")
	motion = lerp(self.global_position,player.global_position,speed)

func _physics_process(delta):
	if player != null:
		targetx = ((player.global_position.x-50)-self.global_position.x)
	#print(player.global_position) 
	# Add the gravity.
	if not is_on_floor():
		velocity.y += Vector2(get_gravity() * delta).y
		
	#look_at(player.global_position)
	if is_on_floor():
		#look_at(player.global_position)
		
		match dialog.linecount:
			2:
				triggered = true
		
		if triggered == true:
			match handstate:
				
				0:
					attackidle(delta)
					if dialog.linecount == 2:
						handstate = 1
				
				1:
					sprite.play("Run")
					velocity.x = targetx*speed*delta
				2:
					pass
	
	#
	move_and_slide()

func attackidle(delta):
	velocity = Vector2(randf_range(100,300), randf_range(-100,-300))
	await timer.timeout
	if global_position != initpos:
		timer.start()
		velocity = (initpos - self.global_position)*speed*delta


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		cooldown()
		handstate = 2
		sprite.play("Catch")
		animation_player.play("Attack")
		var children : Camera2D = body.find_child("Camera2D")
		children.position_smoothing_enabled = false
		var new = body.get_hit()
		children.reparent(new)
		new.apply_central_impulse(Vector2(1500, -200))
		player = new
		
		
	if body.is_in_group("Playerrag"):
		cooldown()
		handstate = 2
		sprite.play("Ang-Start")
		



func _on_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		#state = 0
		pass


func _on_scale_button_green_pressed(state, body):
	handstate = 1
	print("Cambio")


func _on_animated_sprite_2d_animation_finished():
	if sprite.animation == "Catch":
		handstate = 1
	if sprite.animation == "Ang-Start":
		sprite.play("Ang-Loop")

func cooldown():
	area_2d.set_deferred("monitoring", false)
	hit_cooldown.start()

func _on_hit_cooldown_timeout():
	area_2d.set_deferred("monitoring", true)




func _on_cerca_body_entered(body):
	if body.is_in_group("Player"):
		handstate = 2
		sprite.play("Catch")
