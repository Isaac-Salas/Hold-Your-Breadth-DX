@tool
extends Node2D
class_name TransitionScene
@onready var ap: AnimationPlayer = $AnimationPlayer
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@export var target_scene: PackedScene
signal Opendone
signal Closedone


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio.play()
	show()
	ap.play("Opening")

func transition_to(_next_scene : PackedScene) -> void:
	
	ap.play("Closing")
	await(ap.animation_finished)
	#var nivel : Node2D = get_tree().get_first_node_in_group("Nivel")
	#nivel.visible = false
	get_tree().change_scene_to_packed(_next_scene)

func transition_path(path : String) -> void:
	ap.play("Closing")
	await(ap.animation_finished)
	get_tree().change_scene_to_file(path)

func _on_trigger_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		transition_to(target_scene)


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Opening":
		Opendone.emit()
		print("Opendone")
	elif anim_name == "Closing":
		Closedone.emit()
		print("Closedone")
