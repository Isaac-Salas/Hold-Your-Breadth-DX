extends RigidBody2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var player 
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("Player")
	animated_sprite_2d.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	player = get_tree().get_first_node_in_group("Player")
	if player:
		apply_central_impulse((player.global_position-self.global_position)*2)
