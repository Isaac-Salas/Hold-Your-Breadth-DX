extends Node2D
@onready var audio= $AudioStreamPlayer2D

@onready var particles = $GPUParticles2D

# Called when the node enters the scene tree for the first time.
func _ready():
	audio.pitch_scale = randf_range(1.0, 2.0)
	particles.emitting = true
	await particles.finished
	queue_free()
