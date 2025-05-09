extends StaticBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var ap: AnimationPlayer = $AnimationPlayer
@export var isOpen = false
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
var first = true

func _ready() -> void:
	toggle_door(isOpen, 0)
	if get_parent().has_signal("pressed"):
		get_parent().connect("pressed", toggle_door)
	ap.speed_scale = 1

func toggle_door(state, body):
	isOpen = !isOpen
	if isOpen:
		anim.play("open")
		ap.play("shuttingcol")
		if first:
			first = false
			return
		audio_stream_player.play()
	else:
		if first:
			first = false
			return
		anim.play_backwards("open")
		ap.play_backwards("shuttingcol")
		audio_stream_player.play()
