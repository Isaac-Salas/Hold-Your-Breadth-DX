extends Node
@export var slide : Slide
@export var changer : SlideChanger
var move_counter : int
var moved : bool = true


func _on_slide_temp_visibility_changed() -> void:
	if slide.visible == true:
		if changer != null:
			changer.lock_input = true
			


func _on_button_red_2_pressed(state: Variant, body: Variant) -> void:
	if state == true:
		if changer != null:
			changer.lock_input = false
			changer.drop_current_slide()
