@tool
extends Sprite2D
@export_color_no_alpha var color
@onready var light1: PointLight2D = $PointLight2D
@onready var light2: PointLight2D = $PointLight2D2

func _ready() -> void:
	light1.color = color
	light2.color = color
