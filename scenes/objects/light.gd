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


func _on_visible_on_screen_notifier_2d_screen_entered():
	light.visible = true
	light.enabled = true
	fakelight.visible = true


func _on_visible_on_screen_notifier_2d_screen_exited():
	light.visible = false
	light.enabled = false
	fakelight.visible = false
