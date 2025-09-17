extends Node
@export var label : RichTextLabel
@export var target_sprite : AnimatedSprite2D

func _ready() -> void:
	if target_sprite != null:
		target_sprite.animation_finished.connect(start_anim)

func start_anim():
	animate(label)

func animate(target : RichTextLabel):
	var tween : Tween
	if tween == null:
		tween = create_tween()
	else:
		tween.kill()
	tween.tween_property(target,"modulate",Color("969696"),1.0)
