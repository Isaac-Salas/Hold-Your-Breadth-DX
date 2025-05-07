extends Node2D
@onready var transition : TransitionScene = $Transition
const INTRO_CINEMATIC = preload("res://scenes/levels/TitleScreen/intro_cinematic.tscn")
func _on_timer_timeout():
	transition.transition_to(INTRO_CINEMATIC)
