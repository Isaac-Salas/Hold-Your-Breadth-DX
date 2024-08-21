extends RigidBody2D
var  player : SlimePlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player = get_tree().get_first_node_in_group("Player")



func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		player = get_tree().get_first_node_in_group("Player")


func _on_timer_timeout():
	if player:
		self.apply_central_impulse((self.global_position-player.global_position)*10)
	
