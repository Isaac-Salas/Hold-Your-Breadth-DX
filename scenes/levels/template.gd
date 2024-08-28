extends Node2D

@onready var transition: Node2D = $Transition

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()
