extends StaticBody2D

@onready var raycast: RayCast2D = $RayCast2D
@export var target_scale = Vector2(2.0,2.0)
var hit = Vector2(0,200)
@onready var line: Line2D = $Line2D
@onready var hitsprite: AnimatedSprite2D = $hitsprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.is_in_group("button_actionable"):
			collider.set_size(target_scale)
	line.global_position = raycast.global_position
	line.add_point(Vector2(0,0))
	line.add_point(raycast.target_position)
	line.width = 3
	hitsprite.global_position = raycast.target_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var collider = raycast.get_collider()
	if raycast.is_colliding() and collider.global_position != hit:
		hit = collider.global_position
		line.set_point_position(1,Vector2(raycast.get_collision_point().distance_to(line.global_position),0))
		line.width = 3
		hitsprite.global_position = raycast.get_collision_point()
		if collider.is_in_group("button_actionable") and !collider.is_in_group("Meatbox"):
			collider.set_size(target_scale)
			
			#collider._on_ray_collided(target_size)
			#GlobalVar.MinCap = target_size
			#GlobalVar.MaxCap = target_size
			#GlobalVar.sizefactor = target_size
