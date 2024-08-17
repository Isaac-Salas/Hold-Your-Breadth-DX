extends AnimatedSprite2D
class_name SwordOrbComponent
@onready var MousePos
@onready var GlobalMP
@onready var VelVec
@export var radius = 25
@export var factor = 1
@export var player : Node2D

func _process(delta):

		MousePos = get_local_mouse_position()
		rotation += MousePos.angle()*(delta*factor)
		#print("Show")
		var mouse_pos = get_global_mouse_position()
		var player_pos = player.global_transform.origin 
		var distance = player_pos.distance_to(mouse_pos) 
		var mouse_dir = (mouse_pos-player_pos).normalized()
		if distance > radius:
			mouse_pos = player_pos + (mouse_dir * radius)
		self.global_transform.origin = mouse_pos
		
		
		VelVec = Vector2(self.global_position-player_pos)
		#GlobalMP = get_global_mouse_position()
		#position += (GlobalMP - position)*(delta*3)
		#position.x = clamp(position.x, -20, 20)
		#position.y = clamp(position.y, -20, 20)
		
