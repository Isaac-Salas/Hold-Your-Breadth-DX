extends Node2D
#@onready var string : ButtonCable = $String
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@export var isON = false
@onready var light = $PointLight2D
@onready var particles = $CPUParticles2D

func _ready() -> void:
	
	#string.set_start(self.global_position)
	#string.set_last(get_parent().global_position)
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
