extends Area2D

@onready var tp_pos: Marker2D = $"Teleport Position"

func _on_body_entered(body: Node2D) -> void:
	print(body.global_position, tp_pos.global_position)
	if body.is_in_group("throwable"):
		body.global_position = tp_pos.global_position
		body.linear_velocity = Vector2(0,0)
