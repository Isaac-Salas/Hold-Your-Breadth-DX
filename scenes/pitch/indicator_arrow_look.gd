extends Sprite2D
@export var player : SlimePlayer



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player != null:
		look_at(player.global_position)
