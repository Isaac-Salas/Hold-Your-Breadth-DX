class_name botonciyo 
extends Button
@export var Zone : int
@export var Level : int
@onready var sprite: AnimatedSprite2D = $levelbtn
@onready var unlocked: AnimatedSprite2D = $unlocked
@export var transition : TransitionScene
@onready var light: PointLight2D = $light
@onready var og_color : Color
@export var preview : Texture2D
@export var preview_shower : PreviewShower


var updated = false
func _ready() -> void:
	og_color = light.color
	if disabled == true:
		sprite.play("locked")
		unlocked.play("locked")
	else:
		sprite.play("locked")
		unlocked.play("unlocked")
	self.connect("mouse_entered", _on_mouse_entered)
	self.connect("mouse_exited", _on_mouse_exited)
	self.connect("pressed", _on_pressed)
	self.connect("focus_entered",_on_focus_entered)
	self.connect("focus_exited",_on_focus_exited)

func update():
	if !updated:
		if disabled == true:
			sprite.play("locked")
			unlocked.play("locked")
		else:
			sprite.play("locked")
			unlocked.play("unlocked")
		updated = true

func _on_pressed() -> void:
	var newpath = str("_", Zone, "_", Level)
	print(newpath)
	var newscene = Preloader.get(newpath)
	transition.transition_to(newscene)
	

func entered():
	if disabled == true:
		#print("Disable enter")
		light.color = Color(1.0,0.0,0.0,1.0)
		light.enabled = true
		return
	if preview != null:
		preview_shower.texture = preview
	light.enabled = true
	if not sprite.is_playing():
		sprite.play("start")
	await sprite.animation_finished
	sprite.play("loop")

func exited():
	if disabled == true:
		#print("Disable exit")
		light.enabled = false
		return
	if preview != null:
		preview_shower.texture = null
	light.enabled = false
	await sprite.animation_looped
	sprite.play("finish")
	await sprite.animation_finished
	sprite.play("locked")
	

func _on_mouse_entered() -> void:
	entered()

func _on_mouse_exited() -> void:
	exited()


func _on_focus_entered() -> void:
	entered()


func _on_focus_exited() -> void:
	exited()
