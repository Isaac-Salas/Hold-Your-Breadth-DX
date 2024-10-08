extends StaticBody2D
@onready var ap: AnimationPlayer = $AnimationPlayer
@onready var as2d: AnimatedSprite2D = $AnimatedSprite2D

func _on_keyhole_body_entered(body: Node2D) -> void:
	if body.is_in_group("rigidbarnacle"):
		body.queue_free()
		as2d.play("eaten")
		ap.play("OPEN")
		await(ap.animation_finished)
		queue_free()
