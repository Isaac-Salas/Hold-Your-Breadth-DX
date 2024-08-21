extends Node2D
@onready var play = $Play


@onready var exit = $Exit
@onready var transition: Node2D = $Transition

const TESTING = preload("res://scenes/levels/testing.tscn")
const scale_lvl = preload("res://scenes/levels/Tutorial_Level.tscn")
const SCENE_SWITCHER = preload("res://scenes/levels/scene_switcher.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	Manager.load_data()
	transition.ap.play("Opening")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_pressed():
	transition.transition_to(scale_lvl)


func _on_level_select_pressed():
	pass # Replace with function body.


func _on_credits_pressed():
	pass # Replace with function body.


func _on_exit_pressed():
	pass # Replace with function body.


func _on_exit_mouse_entered() -> void:
	$Exit/ExitSprite.play("hover")




func _on_level_select_mouse_entered() -> void:
	$LevelSelect/LevelSprite.play("hover")


func _on_play_mouse_entered() -> void:
	$Play/PlaySprite.play("hover")


func _on_play_mouse_exited() -> void:
	await($Play/PlaySprite.animation_finished)
	$Play/PlaySprite.play("normal")


func _on_level_select_mouse_exited() -> void:
	await($LevelSelect/LevelSprite.animation_finished)
	$LevelSelect/LevelSprite.play("normal")





func _on_exit_mouse_exited() -> void:
	await($Exit/ExitSprite.animation_finished)
	$Exit/ExitSprite.play("normal")


func _on_button_pressed():
	get_tree().change_scene_to_packed(SCENE_SWITCHER)
