extends Node2D

class_name SwingingEye
const TENTACLE_BOMB = preload("res://scenes/bosses/Eyeboss/tentacle_bomb.tscn")

@onready var line_2d = $String/Line2D
@onready var string = $String
@onready var lightr = $Light
@export var scaling : Vector2
@onready var sprite_2d = $Light/Sprite2D
@onready var collision_shape_2d = $Light/CollisionShape2D
@onready var light: PointLight2D = $Light/PointLight2D
@onready var puntocent: StaticBody2D = $Puntocent


@onready var lightphy : RigidBody2D = $Light
@onready var visible_on_screen_notifier_2d = $Light/VisibleOnScreenNotifier2D

@onready var fakelight = $Light/Fakelight
@onready var pin_joint_2d = $PinJoint2D
@export var marker : Marker2D
const BLOOD_PARTICLES = preload("res://scenes/bosses/Eyeboss/bloodParticles.tscn")
@export var wait : float = 0

@onready var clinck = $Light/Clinck
@export var drop : bool
@onready var spawner_component: SpawnerComponent = $SpawnerComponent
@export var hang : bool 

@onready var position_tween : Tween


# Called when the node enters the scene tree for the first time.
func _ready():
	if drop == true:
		droplight()
	
	if hang == true:
		lightphy.set_deferred("freeze", false)
	else:
		lightphy.set_deferred("freeze", true)
		lightphy.position = Vector2(0,16)
		
	scaling = self.scale
	string.ropeLength = light.position.y
	sprite_2d.scale = scaling
	collision_shape_2d.scale = scaling
	light.scale = scaling
	fakelight.scale = scaling
	pin_joint_2d.scale = scaling
	if marker != null:
		lightphy.set_deferred("global_position", marker.global_position)
	if wait != 0:
		await(get_tree().create_timer(wait).timeout)
	
	lightphy.freeze = false
	#line_2d.width = scale.x/2

# Called every frame. 'delta' is the elapsed time since the previous frame.

func hang_activate():
	print("ACTIVATE!")
	hang = true
	lightphy.set_deferred("freeze", false)

func _on_visible_on_screen_notifier_2d_screen_exited():
	light.visible = false


func _on_visible_on_screen_notifier_2d_screen_entered():
	pass
	light.visible = true
	

func droplight():
	if pin_joint_2d != null:
		spawner_component.spawn(light.global_position, self.get_parent())
		var newpos : Marker2D = Marker2D.new()
		newpos.position = lightphy.position
		pin_joint_2d.queue_free()
		lightphy.queue_free()
		add_child(newpos)
		var newblood : GPUParticles2D = BLOOD_PARTICLES.instantiate()
		newblood.amount *= 20
		newblood.lifetime /= 2
		newblood.restart()
		newblood.one_shot = true
		puntocent.add_child(newblood)
		string.light = newpos
		var new_bomb = TENTACLE_BOMB.instantiate()
		new_bomb.punto_cent = newpos
		self.add_child(new_bomb)
		animate_pos(newpos)
		string.crazy_mode = true
		await position_tween.finished
		string.crazy_mode = false
		

func animate_pos(target : Node2D):
	reset_anim()
	position_tween.tween_property(
		target, "position", target.position - Vector2(0.0,200.0), 1.0
	)



func reset_anim():
	if position_tween:
		position_tween.kill()
	position_tween = create_tween()

func dropdown():
	pin_joint_2d.queue_free()
	string.queue_free()
	fakelight.visible = false
	light.visible = false
	light.enabled = false


func _on_light_body_entered(body):
	if hang == true:
		if body.is_in_group("throwable"):
			droplight()

	#clinck.pitch_scale = randf_range(1.0, 2.0)
	#clinck.play()
