extends Node2D
@onready var transition : TransitionScene = $Transition
const LEVEL_SELECT = preload("res://scenes/levels/Level_Select/Level_select.tscn")
func _on_timer_timeout():
	transition.transition_to(LEVEL_SELECT)
