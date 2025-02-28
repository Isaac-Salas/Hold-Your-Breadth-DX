extends Node2D
@onready var transition : TransitionScene = $Transition

func _on_timer_timeout():
	transition.transition_to(transition.target_scene)
