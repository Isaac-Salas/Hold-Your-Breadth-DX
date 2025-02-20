extends Node2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var audio_stream_player = $AudioStreamPlayer
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite_2d.animation_finished.connect(start)
	audio_stream_player.finished.connect(loop)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start():
	animation_player.play("new_animation")

func loop():
	#audio_stream_player.play(ENDLESS_LOOP)
	pass


func _on_timer_timeout():
	animated_sprite_2d.play("default")
	timer.stop()
