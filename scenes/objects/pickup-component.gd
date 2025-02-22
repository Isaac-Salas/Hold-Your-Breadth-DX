extends RigidBody2D
class_name ObjectClass
@onready var colision = $CollisionShape2D
@onready var sprite = $Sprite2D
@onready var indicator = $Sprite2D/PointLight2D
@onready var spawner_component = $SpawnerComponent
@export var destroyplace : Node2D
@onready var light_occluder_2d: LightOccluder2D = $LightOccluder2D
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@export var break_after_throw : bool = false
@onready var sprite_2d = $Sprite2D
@onready var detector = $Detector

const OUTLINE = preload("res://scenes/objects/Shaders/outline.gdshader")

func _on_detector_area_entered(area):
	if area is ObjectDetect:
		print("Highlight!")
		var newmat = ShaderMaterial.new()
		newmat.shader = OUTLINE
		newmat.set_shader_parameter("width", 2)
		newmat.set_shader_parameter("outline_color", Color("ffaa00"))
		#newmat.set_shader_parameter("flickering_speed", 20)
		sprite_2d.material = newmat
		indicator.visible = true


func _on_detector_area_exited(area):
	if area is ObjectDetect:
		indicator.visible = false
		sprite_2d.material = null
		

func destroy():
	self.queue_free()
	var new = spawner_component.spawn()
	if destroyplace:
		new.global_position = destroyplace.global_position
	else:
		new.global_position = self.global_position

func set_size(target_size):
	colision.scale = target_size/2.5
	sprite.scale = target_size/2
	light_occluder_2d.scale = target_size/2
	detector.scale = target_size/2


func _on_body_entered(body):
	audio_stream_player_2d.pitch_scale = randf_range(3,6)
	audio_stream_player_2d.play()
	if break_after_throw == true:
		destroy()
