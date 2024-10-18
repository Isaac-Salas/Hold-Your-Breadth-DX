extends Node2D
@onready var fondo = $Fondo
@onready var slime = $Slime


# Called when the node enters the scene tree for the first time.
func _ready():
	fondo.play("Inicio")
	slime.play("Inicio")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
