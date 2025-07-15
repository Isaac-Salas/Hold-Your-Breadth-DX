extends Node2D
@export var tentacle_amount : int = 1
@onready var string: StringComponent = $String
@onready var ray_cast_2d: RayCast2D = $RayCast2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_2d !=null and ray_cast_2d.rotation_degrees < 360.0:
		ray_cast_2d.rotation_degrees += 10
		print(ray_cast_2d.get_collision_point())
	elif ray_cast_2d != null :
		ray_cast_2d.queue_free()
	
