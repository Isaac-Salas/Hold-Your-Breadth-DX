
extends Node2D
@onready var light = $Light
@export var lenght : int = 20
# Called when the node enters the scene tree for the first time.
func _ready():
	light.position.y = lenght


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
