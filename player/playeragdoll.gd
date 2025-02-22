extends RigidBody2D
class_name RigidPlayer
@export var canrevive : bool = false
@onready var PLAYER = load("res://player/player.tscn")
@onready var spawner_component : SpawnerComponent = $SpawnerComponent
@onready var colision= $CollisionShape2D
@onready var shake_component = $ShakeComponent


# Called when the node enters the scene tree for the first time.
func _ready():
	shake_component.tween_shake()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if canrevive == true:
		#print("Se puede parar y bailar")
		if Input.is_anything_pressed():
			spawner_component.scene = PLAYER
			var new = spawner_component.spawn()
			new.global_position = self.global_position
			self.queue_free()

func revived():
	canrevive = true
