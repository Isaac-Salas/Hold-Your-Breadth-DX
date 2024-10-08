extends Area2D

@onready var tp_pos: Marker2D = $Marker2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("throwable"):
		body.global_position = tp_pos.global_position
