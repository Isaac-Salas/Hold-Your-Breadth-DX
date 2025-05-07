extends RigidBody2D
var picked = false
var start = true
var count = false
@onready var timerst = $Timer
@onready var sprite= $Sprite2D
@onready var colision = $CollisionShape2D
@onready var animation_player = $AnimationPlayer
@onready var player : SlimePlayer
@export var Lastingtime = 6.0
@onready var spawner_component = $SpawnerComponent
@onready var indicator = $Sprite2D/Indicator

const OUTLINE = preload("res://scenes/objects/Shaders/outline.gdshader")

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(picked, count)
	player = get_tree().get_first_node_in_group("Player")
	
	if player:
		if picked == true and count == true:
			timer()
			animation_player.speed_scale = (6.0/Lastingtime)
			animation_player.play("blink")
			#print(timerst.time_left))
			colision.scale = player.colision.scale
			sprite.scale = colision.scale




func reset():
		#colision.scale = Vector2(1,1)
		#sprite_2d.scale = Vector2(1,1)
		count = false
		picked = false
		#set_disable_scale(true)
		



func timer():
	if start == true:
		timerst.start(Lastingtime)
		start = false
		

func _on_body_entered(body):
	if picked == true:
		print(body.name)
		count = true


func _on_timer_timeout():
	animation_player.stop()
	animation_player.play("RESET")
	reset()


func _on_detector_area_entered(area):
	if area is ObjectDetect and area.get_parent().get_parent().sprite.scale >= sprite.scale:
		print("Highlight!")
		var newmat = ShaderMaterial.new()
		newmat.shader = OUTLINE
		newmat.set_shader_parameter("width", 2)
		newmat.set_shader_parameter("outline_color", Color("ffaa00"))
		#newmat.set_shader_parameter("flickering_speed", 20)
		sprite.material = newmat
		indicator.visible = true
	elif area is ObjectDetect:
		var newmat = ShaderMaterial.new()
		newmat.shader = OUTLINE
		newmat.set_shader_parameter("width", 1)
		newmat.set_shader_parameter("outline_color", Color("ff1111"))
		#newmat.set_shader_parameter("flickering_speed", 20)
		sprite.material = newmat
		indicator.visible = true


func _on_detector_area_exited(area):
	if area is ObjectDetect:
		indicator.visible = false
		sprite.material = null
		
