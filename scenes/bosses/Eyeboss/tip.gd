extends Bone2D
@export var player : SlimePlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player != null:
		var player_pos = to_local(player.global_position)
		#player_pos.y = 0
		look_at(player_pos)
