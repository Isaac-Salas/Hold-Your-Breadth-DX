extends CharacterBody2D


@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var player : Node2D
@onready var timer = $Timer
@export var speed = 0.01
@onready var handstate : int = 0

var motion : Vector2
var gravity2 : Vector2
var targetx : float
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("Player")
	animated_sprite_2d.play("Idle")
	motion = lerp(self.global_position,player.global_position,speed)

func _physics_process(delta):
	targetx = ((player.global_position.x-150)-self.global_position.x)
	#print(player.global_position) 
	# Add the gravity.
	if not is_on_floor():
		velocity.y += Vector2(get_gravity() * delta).y
		
	#look_at(player.global_position)
	if is_on_floor():
		#look_at(player.global_position)
		match handstate:
			
			0:
				pass
			
			1:
				velocity.x = targetx*speed*delta
	
	#
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		#state = 2
		pass
		


func _on_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		#state = 0
		pass


func _on_scale_button_green_pressed(state, body):
	handstate = 1
	print("Cambio")
