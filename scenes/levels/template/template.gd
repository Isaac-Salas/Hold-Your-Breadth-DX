extends Node2D

@onready var transition: Node2D = $Transition
@export var ZoneNumber : int
@export var LevelNumber : int
@export var Checkpoint : bool 
@onready var character = $CharacterBody2D2
@onready var checkpoint_pos = $Checkpoint


func _ready():
	if Checkpoint == true:
		character.global_position = checkpoint_pos.global_position
	var LevelSave : String = "Level" + str(ZoneNumber) + "_" + str(LevelNumber)
	Manager.setter(LevelSave,true)
	Manager.save_game()
	

	
	
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()
