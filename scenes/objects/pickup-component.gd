extends RigidBody2D
class_name ObjectClass
@onready var colision = $CollisionShape2D
@onready var sprite = $Sprite2D
@onready var indicator = $Sprite2D/PointLight2D
@onready var spawner_component = $SpawnerComponent


func _on_detector_area_entered(area):
	if area is ObjectDetect:
		indicator.visible = true


func _on_detector_area_exited(area):
	if area is ObjectDetect:
		indicator.visible = false

func destroy():
	self.queue_free()
	var new = spawner_component.spawn()
	new.global_position = self.global_position

func set_size(target_size):
	colision.scale = target_size/2
	sprite.scale = target_size
