@tool
extends Node2D

@onready var ap: AnimationPlayer = $AnimationPlayer
@export var target_scene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show()
	ap.play("Opening")

func transition_to(_next_scene) -> void:
	ap.play("Closing")
	await(ap.animation_finished)
	get_tree().change_scene_to_packed(_next_scene)


func _on_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		transition_to(target_scene)
