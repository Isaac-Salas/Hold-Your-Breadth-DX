extends RigidBody2D
class_name PickupComponent
@onready var colision = $CollisionShape2D
@onready var sprite = $Sprite2D
@onready var indicator = $Sprite2D/PointLight2D


func _on_detector_area_entered(area):
	if area is ObjectDetect:
		indicator.visible = true


func _on_detector_area_exited(area):
	if area is ObjectDetect:
		indicator.visible = false
