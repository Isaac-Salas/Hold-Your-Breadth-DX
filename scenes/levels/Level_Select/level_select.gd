extends Node2D
@onready var _1_1 = $"Control/1-1"
@onready var _1_2 = $"Control/1-2"
@onready var _1_3 = $"Control/1-3"
@onready var _2_1 = $"Control/2-1"
@onready var _3_1 = $"Control/3-1"
@onready var _3_2 = $"Control/3-2"
@onready var _3_3 = $"Control/3-3"
@onready var _4_1 = $"Control/4-1"
@onready var _4_2 = $"Control/4-2"
@onready var _4_3 = $"Control/4-3"
@onready var _5_1 = $"Control/5-1"
@onready var _5_2 = $"Control/5-2"
@onready var _5_3 = $"Control/5-3"
@onready var control = $Control
const Levels : GDScript = preload("res://scenes/levels/Transition/Levels.gd")
@onready var boss = $Control/BOSS
@onready var transition = $Transition


# Called when the node enters the scene tree for the first time.
func _ready():
	#Manager.Level1_1 = true
	#Manager.save_game()
	Manager.load_game()
	print(Manager.Level1_1)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	match Manager.Level1_1:
		true:
			_1_1.disabled = false
			
		false:
			_1_1.disabled = true
	
	match Manager.Level1_2:
		true:
			_1_2.disabled = false
		false:
			_1_2.disabled = true
	
	match Manager.Level1_3:
		true:
			_1_3.disabled = false
		false:
			_1_3.disabled = true
			
	match Manager.Level2_1:
		true:
			_2_1.disabled = false
		false:
			_2_1.disabled = true
	
	match Manager.Level3_1:
		true:
			_3_1.disabled = false
		false:
			_3_1.disabled = true
	
	match Manager.Level3_2:
		true:
			_3_2.disabled = false
		false:
			_3_2.disabled = true
	
	match Manager.Level3_3:
		true:
			_3_3.disabled = false
		false:
			_3_3.disabled = true
			
	match Manager.Level4_1:
		true:
			_4_1.disabled = false
		false:
			_4_1.disabled = true
	
	match Manager.Level4_2:
		true:
			_4_2.disabled = false
		false:
			_4_2.disabled = true
		
	match Manager.Level4_3:
		true:
			_4_3.disabled = false
		false:
			_4_3.disabled = true
	
	match Manager.Level5_1:
		true:
			_5_1.disabled = false
		false:
			_5_1.disabled = true
	
	match Manager.Level5_2:
		true:
			_5_2.disabled = false
		false:
			_5_2.disabled = true
			
	match Manager.Level5_3:
		true:
			_5_3.disabled = false
		false:
			_5_3.disabled = true
		
	match Manager.Level6_66:
		true:
			boss.disabled = false
		false:
			boss.disabled = true
	

	
		
		
		
		
		
		


func _on_timer_timeout():
	pass
	#print(Manager.Firsttime)
	#print(Manager.Level1_1)
	#print(Manager.Level1_2)
	#print(Manager.Level1_3)
	#print(Manager.Level2_1)
	#print(Manager.Level3_1)
	#print(Manager.Level3_2)
	#print(Manager.Level3_3)
	#print(Manager.Level4_1)
	#
	#
	
	
	
	



func _1_1_on__pressed():
	var _1_1_TUTORIAL_THROW = load("res://scenes/levels/game_sequence/1-1_Tutorial_throw.tscn")
	transition.transition_to(_1_1_TUTORIAL_THROW)
	


func _1_2_on__pressed():
	var _1_2_DOORS_AND_BUTTONS = load("res://scenes/levels/game_sequence/1-2 Doors and buttons.tscn")
	get_tree().change_scene_to_packed(_1_2_DOORS_AND_BUTTONS)


func _on_back_pressed():
	var tutorial = load("res://scenes/levels/TitleScreen/intro_cinematic.tscn")
	transition.transition_to(tutorial)


func _on_reset_progress_pressed():
	Manager.reset_progress()
