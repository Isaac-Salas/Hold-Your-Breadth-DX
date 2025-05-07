extends Node2D



@onready var transition = $CharacterBody2D2/Transition
@onready var dialog_box = $Hamster/Hamster/DialogBox

@export var ZoneNumber : int
@export var LevelNumber : int
@export var Checkpoint : bool 
@onready var character = $CharacterBody2D2
@onready var checkpoint_pos = $Checkpoint
@onready var lights = $Lights

@onready var player = $CharacterBody2D2
const _2_1_CHASE_CHANGE = preload("res://scenes/levels/game_sequence/2-1_CHASEChange.tscn")
const _3_1_SCALE_LEVEL = preload("res://scenes/levels/game_sequence/3-1 Scale level.tscn")


func _ready():
	if Checkpoint == true:
		character.global_position = checkpoint_pos.global_position
	var LevelSave : String = "Level" + str(ZoneNumber) + "_" + str(LevelNumber)
	Manager.setter(LevelSave,true)
	Manager.save_game()
	

	
	
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()
func _on_button_red_pressed(state, body):
	
	var allLights = lights.get_children()
	for light in allLights:
		light.dropdown()
	var obstacles = _2_1_CHASE_CHANGE.instantiate()
	self.add_child(obstacles)
	


func _on_player_detector_body_entered(body):
	if body is SlimePlayer:
		$Clutter/Lasers.queue_free()
		var biobox = $Clutter/Bio_Box.get_children()
		for things in biobox:
			things.global_position.x += 500
		
		player.set_physics_process(false)


func _on_dialog_box_done():
	if dialog_box.linecount == 5:
		player.set_physics_process(true)


func _on_area_2d_body_entered(body):
	if body is SlimePlayer:
		transition.visible = true
		transition.transition_to(_3_1_SCALE_LEVEL)
