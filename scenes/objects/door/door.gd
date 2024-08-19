extends StaticBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var ap: AnimationPlayer = $AnimationPlayer
@export var isOpen = false

func toggle_door(state, body):
	isOpen = state
	if isOpen:
		anim.play("open")
		ap.play("shuttingcol")
	else:
		anim.play_backwards("open")
		ap.play_backwards("shuttingcol")
