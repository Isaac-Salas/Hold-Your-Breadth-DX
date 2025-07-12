extends Sprite2D
@onready var player : SlimePlayer
@export var follow_mouse : bool
@onready var swinging_eye: Node2D = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var treetest = swinging_eye.get_tree()
	player = treetest.get_first_node_in_group("Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if follow_mouse == true and player == null:
		look_at(get_global_mouse_position())
	if player != null:
		look_at(player.global_position)
