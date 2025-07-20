extends Area2D
@export var knock : KnockbackComponent


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("throwable"):
		var buffer = body
		knock.anchor = body
		knock.knock_anim()
