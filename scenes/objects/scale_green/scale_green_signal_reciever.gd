extends Node2D
@onready var light = $PointLight2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@export var isON = false
@onready var particles = $CPUParticles2D

func _ready() -> void:
	if get_parent().has_signal("pressed"):
		get_parent().connect("pressed", toggle_door)
func toggle_door(state, body):
	isON = state
	if isON:
		particles.restart()
		particles.emitting = true
		anim.play("ON")
		light.show()
	else:
		anim.play_backwards("OFF")
		light.hide()
