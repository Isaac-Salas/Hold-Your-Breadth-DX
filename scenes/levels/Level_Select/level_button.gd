class_name botonciyo 
extends Button
@export var lvl_path : String = ""
@onready var sprite: AnimatedSprite2D = $levelbtn
@onready var unlocked: AnimatedSprite2D = $unlocked
@export var transition : TransitionScene

var updated = false
func _ready() -> void:
	if disabled == true:
		sprite.play("locked")
		unlocked.play("locked")
	else:
		sprite.play("locked")
		unlocked.play("unlocked")
	self.connect("mouse_entered", _on_mouse_entered)
	self.connect("mouse_exited", _on_mouse_exited)
	self.connect("pressed", _on_pressed)

func _on_mouse_entered() -> void:
	if disabled == true:
		return
	if not sprite.is_playing():
		sprite.play("start")
	await sprite.animation_finished
	sprite.play("loop")

func update():
	if !updated:
		if disabled == true:
			sprite.play("locked")
			unlocked.play("locked")
		else:
			sprite.play("locked")
			unlocked.play("unlocked")
		updated = true

func _on_mouse_exited() -> void:
	if disabled == true:
		return
	await sprite.animation_looped
	sprite.play("finish")
	await sprite.animation_finished
	sprite.play("locked")
	

func _on_pressed() -> void:
	if lvl_path == "":
		return
	var lvl = load(lvl_path)
	transition.transition_to(lvl)
