extends Node
@onready var lvl_up: AnimationPlayer = $"../lvl up"
@onready var music_submanager: MusicSubmanager = $"../../MusicSubmanager"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_scale_button_green_pressed(state: Variant, body: Variant) -> void:
	match state:
		true:
			music_submanager.playback_speed = 3.0
			music_submanager.check_manager()
			lvl_up.play("lvl up")
		false:
			music_submanager.playback_speed = 1.0
			music_submanager.check_manager()
			lvl_up.pause()
			
