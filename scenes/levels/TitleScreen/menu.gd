extends Node2D
@onready var play = $Play
@onready var level_select = $LevelSelect
@onready var credits = $Credits
@onready var exit = $Exit
const TESTING = preload("res://scenes/levels/testing.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	Manager.load_data()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_pressed():
	get_tree().change_scene_to_packed(TESTING)


func _on_level_select_pressed():
	pass # Replace with function body.


func _on_credits_pressed():
	pass # Replace with function body.


func _on_exit_pressed():
	pass # Replace with function body.
