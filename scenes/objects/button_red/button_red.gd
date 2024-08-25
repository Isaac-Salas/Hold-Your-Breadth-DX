extends Area2D
@onready var anim_flag: AnimatedSprite2D = $anim_flag
@onready var light: PointLight2D = $PointLight2D
@onready var anim: AnimatedSprite2D = $anim
signal pressed(state, body)
var state = false
var n_inside = 0



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("button_actionable"):
		n_inside += 1
		anim_flag.play("ON")
		if  not state:
			state = true
			anim.play("pressed")
			light.show()
			emit_signal("pressed", state, body)


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("button_actionable"):
		n_inside -= 1
		if state and n_inside == 0:
			anim_flag.play("OFF")
			state = false
			light.hide()
			emit_signal("pressed", state, body)
			anim.play_backwards("pressed")
