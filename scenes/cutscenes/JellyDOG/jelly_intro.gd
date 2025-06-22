extends Node2D
@onready var transition : TransitionScene = $Transition
#Kevin no se la traga
func _on_timer_timeout():
	transition.transition_to(Preloader.INTRO_CINEMATIC)
