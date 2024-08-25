extends StaticBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var ap: AnimationPlayer = $AnimationPlayer
@export var isOpen = false

func _ready() -> void:
	toggle_door(isOpen, 0)
	if get_parent().has_signal("pressed"):
		get_parent().connect("pressed", toggle_door)

func toggle_door(state, body):
	isOpen = !isOpen
	if isOpen:
		anim.play("open")
		ap.play("shuttingcol")
	else:
		anim.play_backwards("open")
		ap.play_backwards("shuttingcol")
