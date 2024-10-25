@tool
extends Sprite2D
@export_color_no_alpha var color
@onready var light: PointLight2D = $PointLight2D
#@onready var light2: PointLight2D = $PointLight2D2
@onready var fakelight = $Fakelight

func _ready() -> void:
	light.color = color
	fakelight.modulate = color
	fakelight.modulate.a8 = 25
#	light2.color = color
