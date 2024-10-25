extends CharacterBody2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var player 
@onready var timer = $Timer
@export var speed = 0.01
var motion : Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("Player")
	animated_sprite_2d.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# put wanted speed here
	look_at(player.global_position)
	motion = lerp(self.position,player.global_position,speed)
	velocity.x = motion.x
	move_and_slide()
	
