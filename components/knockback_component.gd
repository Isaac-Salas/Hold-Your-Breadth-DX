extends Node2D
class_name KnockbackComponent
@export var target : Node2D
@export var anchor : Node2D
@export var knockback_amount : float = 1.0
@export var time_hit : float = 0.03
@export var time_cooldown: float = 0.3
var knock_tween : Tween
var og_target_position : Vector2


func knock_anim():
	og_target_position = to_global(target.position)
	var angle = og_target_position - anchor.position * knockback_amount
	reset_anim()
	knock_tween.tween_property(
		target, "global_position", angle, time_hit
	)
	await knock_tween.finished
	cooldown_anim()


func cooldown_anim():
	reset_anim()
	knock_tween.tween_property(
		target, "global_position", og_target_position, time_cooldown
	)

func reset_anim():
	if knock_tween:
		knock_tween.kill()
	knock_tween = create_tween()
