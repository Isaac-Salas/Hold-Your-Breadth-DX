extends Node2D
class_name SlideChanger
@export var lock_input : bool = false
@onready var slides : Array[Slide]
@export var current_slide : int = 0
@export var transition: TransitionScene

func _ready() -> void:
	for slide : Slide in get_children():
		slides.append(slide)

func _input(_event: InputEvent) -> void:
	if lock_input == false:
		if Input.is_action_just_released("OK"):
			drop_current_slide()
			

func drop_current_slide():
	slides[current_slide].drop()
	if current_slide < slides.size() - 1:
		current_slide += 1
		slides[current_slide].visible = true
		print("Size of pres = ", slides.size())
		print("Still Drops on: ", current_slide)
	else:
		if transition.target_scene != "":
			print("Trying trans")
			transition.transition_to(transition.target_scene)
		else:
			OS.shell_open("https://store.steampowered.com/app/3901700/Hold_Your_Breadth_DX/")
