extends RigidBody2D
@onready var revive = false
const PLAYER = preload("res://player/player.tscn")
@onready var spawner_component = $SpawnerComponent
@onready var colision= $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if revive == true:
		
		if Input.is_anything_pressed():
			spawner_component.spawn()
			self.queue_free()
			

func revived():
	revive = true
