extends Node2D
class_name SlideChanger
@export var slides : Array[Slide]
@export var current_slide : int = 0
@onready var transition: TransitionScene = $"../Transition"

func _ready() -> void:
	Manager.reset_progress()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("OK"):
		slides[current_slide].drop()
		if current_slide < slides.size() - 1:
			current_slide += 1
			slides[current_slide].visible = true
		else:
			if transition.target_scene != null:
				transition.transition_to(transition.target_scene)
			
