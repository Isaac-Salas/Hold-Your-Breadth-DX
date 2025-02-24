extends Marker2D
class_name RatFleeMarker
@onready var timer = $Timer

@onready var area_2d = $Area2D
@onready var hole_anim = $HoleAnim
@onready var Spawner : RatSpawn

func  _ready():
	hole_anim.play("Spawned")
	

func _on_area_2d_body_entered(body):
	if body is Rat_enemy:
		Spawner = body.spawnedfrom
		body.queue_free()
		hole_anim.play("Idle")
		timer.start(2)
		


func _on_timer_timeout():
	await hole_anim.animation_looped
	Spawner.reset()
	hole_anim.play("Spawned")
	timer.stop()
