extends Control


func _on__focus_entered(anim: NodePath) -> void:
	print(anim.get_name(0))
