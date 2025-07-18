extends Sprite2D
@onready var player : SlimePlayer
@export var follow_mouse : bool
@export var swinging_eye: SwingingEye

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if swinging_eye != null:
		var tree = swinging_eye.get_tree()
		player = tree.get_first_node_in_group("Player")
	else:
		var tree = self.get_tree()
		player = tree.get_first_node_in_group("Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if follow_mouse == true and player == null:
		look_at(get_global_mouse_position())
	if player != null:
		look_at(player.global_position)
