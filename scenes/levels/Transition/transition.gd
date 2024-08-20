extends Node2D

@onready var ap: AnimationPlayer = $AnimationPlayer
@export var target_scene: PackedScene
		
func transition_to(_next_scene) -> void:
	# Plays the Fade animation and wait until it finishes
	ap.play("Closing")
	await(ap.animation_finished)
	# Changes the scene
	get_tree().change_scene_to_packed(_next_scene)


func _on_trigger_body_entered(body: Node2D) -> void:
	transition_to(target_scene)
