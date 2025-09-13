extends Node
@onready var transition: TransitionScene = $"../Transition"


func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("OK"):
		transition.transition_to(transition.target_scene)
