@tool
extends Node2D
class_name TransitionScene
@onready var ap: AnimationPlayer = $AnimationPlayer
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@export_file("*.tscn") var target_scene: String
signal Opendone
signal Closedone


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio.play()
	show()
	ap.play("Opening")



func transition_to(path : String) -> void:
	ap.play("Closing")
	await ap.animation_finished
	get_tree().change_scene_to_file(path)

func _on_trigger_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		transition_to(target_scene)


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Opening":
		Opendone.emit()
		#print("Opendone")
	elif anim_name == "Closing":
		Closedone.emit()
		#print("Closedone")
