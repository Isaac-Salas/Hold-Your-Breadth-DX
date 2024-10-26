extends CharacterBody2D

@export var dialog : DialogComponent
const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta):
	
	if dialog != null:
		
		match dialog.linecount:
			2:
				dialog.push_font_size(100)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()
