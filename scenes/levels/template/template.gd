extends Node2D


@export var ZoneNumber : int
@export var LevelNumber : int



func _ready():
	var LevelSave : String = "Level" + str(ZoneNumber) + "_" + str(LevelNumber)
	Manager.setter(LevelSave,true)
	Manager.save_game() 
	
	

	
	
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()
