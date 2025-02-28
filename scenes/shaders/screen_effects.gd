extends Node2D
class_name ScreenStuff
@export var showoverride : bool = false
@onready var options_menu = $OptionsMenu


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match showoverride:
		true:
			show()
		false:
			pass
