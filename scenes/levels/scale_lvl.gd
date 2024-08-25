extends Node2D

@onready var transition: Node2D = $Transition

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	transition.ap.play("Opening")

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()
