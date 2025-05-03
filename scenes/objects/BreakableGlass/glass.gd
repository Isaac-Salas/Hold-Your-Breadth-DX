extends Node2D
@onready var audio= $AudioStreamPlayer2D

@onready var particles = $GPUParticles2D

# Called when the node enters the scene tree for the first time.
func _ready():
	particles.emitting = true
	await particles.finished
	queue_free()
