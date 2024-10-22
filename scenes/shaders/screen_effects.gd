extends Node2D
@export var showoverride : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match showoverride:
		true:
			show()
		false:
			pass
