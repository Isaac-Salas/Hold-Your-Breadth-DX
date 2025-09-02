extends StaticBody2D

@onready var raycast: RayCast2D = $RayCast2D
@export var target_scale = Vector2(2.0,2.0)
var hit = Vector2(0,200)
@onready var line: Line2D = $Line2D
@onready var hitsprite: AnimatedSprite2D = $hitsprite
@onready var light: PointLight2D = $PointLight2D2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	line.add_point(Vector2.ZERO)
	line.add_point(raycast.target_position)
	line.width = 3

	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.is_in_group("button_actionable"):
			collider.set_size(target_scale)

		hitsprite.global_position = raycast.get_collision_point()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		var collision_point = raycast.get_collision_point()
		
		if collision_point.distance_to(hit) > 1.0:
			hit = collision_point
			line.set_point_position(1,Vector2(raycast.get_collision_point().distance_to(line.global_position),0))
			line.width = 3
			hitsprite.global_position = collision_point

			if collider.is_in_group("button_actionable") and not collider.is_in_group("Meatbox"):
				collider.set_size(target_scale)
