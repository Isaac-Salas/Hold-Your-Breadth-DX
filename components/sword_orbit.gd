extends AnimatedSprite2D
class_name SwordOrbComponent
@onready var MousePos
@onready var GlobalMP
@onready var VelVec
@export var radius = 25
@export var factor = 1
@export var player : Node2D
@export var debug_controller : bool
@export var normalaim : bool 
@onready var overridevisible : bool

@export var Player : SlimePlayer


func _ready():
	

	
	if debug_controller == true:
		Input.joy_connection_changed.connect(conectedcontroller)


func toggleprocess(toggle : bool):
	match toggle:
		true:
			set_process(true)
		false:
			set_process(false)


func _process(delta):
	MousePos = get_local_mouse_position()
	rotation += MousePos.angle()*(delta*factor)
		#print("Show")
	var mouse_pos = get_global_mouse_position()
	var player_pos = player.global_transform.origin 
	var distance = player_pos.distance_to(mouse_pos) 
	#var stick = Input.get_joy_axis(0,)
	var mouse_dir = (mouse_pos-player_pos).normalized()
	var aimcontroller = Input.get_vector("aim_left", "aim_right","aim_up", "aim_down")
	#print(aimcontroller)
	var joypads = Input.get_connected_joypads()
	if joypads.size() != 0:
		Player.controller = true
		self.global_transform.origin = player.global_position + aimcontroller*radius
		#print(str(self.name, ":", self.transform.origin ))
		if normalaim == true:
			if aimcontroller == Vector2(0.0,0.0):
				self.visible = false
			else:
				self.visible = true
		if overridevisible == true:
			self.visible = false
		
	else:
		Player.controller = false
		if distance > radius:
			mouse_pos = player_pos + (mouse_dir * radius)
		self.global_transform.origin = mouse_pos
		#print(str(self.name, ":", self.transform.origin ))
	
	VelVec = Vector2(self.global_position-player_pos)
		#GlobalMP = get_global_mouse_position()
		#position += (GlobalMP - position)*(delta*3)
		#position.x = clamp(position.x, -20, 20)
		#position.y = clamp(position.y, -20, 20)
		

func conectedcontroller(device: int, connected: bool):
	print("Cambio")
	var joypads = Input.get_connected_joypads()
	print(str("Joypads connected:", joypads))
