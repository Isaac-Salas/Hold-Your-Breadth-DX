extends Node2D

signal romper
@onready var spawner_component = $SpawnerComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group("Breaker"): #or body.is_in_group("Hand") :
		romper.emit()
		queue_free()
		spawner_component.spawn()
