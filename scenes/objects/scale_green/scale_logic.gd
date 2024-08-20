extends Area2D
@onready var anim_flag: AnimatedSprite2D = $anim_flag

@onready var anim: AnimatedSprite2D = $anim
@export var activation_weight : float = 4.0
signal pressed(state, body)
var state = false
var n_inside = 0
var weight_total = 0
var bodies_inside = []
var activated = false

func _process(delta: float) -> void:
	weight_total = 0
	for b in bodies_inside:
		weight_total += b.sprite.scale.x * 2
	if activated != update():
		emit_signal("pressed", state, 2)
		activated = update()

func update():
	if n_inside > 0 and weight_total < activation_weight:
		var frame = 0
		if weight_total < activation_weight * 1 / 5:
			frame = 0
		elif weight_total < activation_weight * 2 / 5:
			frame = 1
		elif weight_total < activation_weight * 3 / 5:
			frame = 2
		else: 
			frame = 3
		anim_flag.play("ON")
		anim_flag.frame = frame
		anim_flag.pause()
		return false
	elif weight_total > activation_weight:
		anim_flag.play("OVER")
		return false
	elif weight_total == activation_weight and not state:
		anim_flag.play("CORRECT")
		return true
	elif anim_flag.animation != "CORRECT":
		anim_flag.play("OFF")
		return false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Layer0":
		return
	bodies_inside.append(body)
	if body.is_in_group("button_actionable"):
		n_inside += 1
		if anim.animation == "depresssed":
			anim.play("pressed")
		update()
		


func _on_body_exited(body: Node2D) -> void:
	bodies_inside.remove_at(bodies_inside.find(body))
	if body.is_in_group("button_actionable"):
		n_inside -= 1
		weight_total -= body.sprite.scale.x * 2
		update()
		if n_inside == 0:
			anim_flag.play("OFF")
			state = false
			anim.play("depresssed")
			#emit_signal("pressed", state, 2)
	if n_inside == 0:
		weight_total = 0
