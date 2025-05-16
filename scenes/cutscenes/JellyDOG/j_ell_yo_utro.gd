extends Node2D


@onready var transition = $Transition
func _on_timer_timeout():
	transition.transition_to(Preloader.LEVEL_SELECT)
