@tool
extends Node2D
class_name TransitionScene
@onready var ap: AnimationPlayer = $AnimationPlayer
@export var target_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show()
	ap.play("Opening")

func transition_to(_next_scene : PackedScene) -> void:
	
	ap.play("Closing")
	await(ap.animation_finished)
	#var nivel : Node2D = get_tree().get_first_node_in_group("Nivel")
	#nivel.visible = false
	get_tree().change_scene_to_packed(_next_scene)


func _on_trigger_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		transition_to(target_scene)
