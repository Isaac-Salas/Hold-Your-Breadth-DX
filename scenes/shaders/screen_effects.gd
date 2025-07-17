extends Node2D
class_name ScreenStuff
@export var showoverride : bool = false
@onready var options_menu = $OptionsMenu
@export var player : SlimePlayer
#@onready var background: Sprite2D = $Background



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match showoverride:
		true:
			show()
		false:
			pass

func _process(delta):
	pass
