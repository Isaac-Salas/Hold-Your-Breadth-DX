extends Node2D



@onready var line_2d = $String/Line2D
@onready var string = $String
@onready var lightr = $Light
@export var scaling : Vector2
@onready var sprite_2d = $Light/Sprite2D
@onready var collision_shape_2d = $Light/CollisionShape2D
@onready var light: PointLight2D = $Light/PointLight2D


@onready var lightphy = $Light
@onready var visible_on_screen_notifier_2d = $Light/VisibleOnScreenNotifier2D

@onready var fakelight = $Light/Fakelight
@onready var pin_joint_2d = $PinJoint2D
@export var marker : Marker2D

@export var wait : float = 0

@onready var clinck = $Light/Clinck
@export var drop : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	if drop == true:
		droplight()
	
	
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
func _process(delta):
	#print(string.ropeLength)
	pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	light.visible = false


func _on_visible_on_screen_notifier_2d_screen_entered():
	
	light.visible = true
	

func droplight():
	pin_joint_2d.queue_free()
	string.queue_free()

func dropdown():
	pin_joint_2d.queue_free()
	string.queue_free()
	fakelight.visible = false
	light.visible = false
	light.enabled = false


func _on_light_body_entered(body):
	pass
	#clinck.pitch_scale = randf_range(1.0, 2.0)
	#clinck.play()
