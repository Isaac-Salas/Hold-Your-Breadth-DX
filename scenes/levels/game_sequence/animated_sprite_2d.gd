extends AnimatedSprite2D


func _on_slide_temp_visibility_changed() -> void:
	play("default")
	frame = 0
