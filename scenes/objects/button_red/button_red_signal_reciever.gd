extends Node2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@export var isON = false

func toggle_door(state, body):
	isON = state
	if isON:
		anim.play("ON")
	else:
		anim.play_backwards("OFF")
