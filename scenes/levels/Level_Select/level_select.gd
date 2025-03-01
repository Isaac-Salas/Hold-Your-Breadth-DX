extends Node2D
@onready var _1_1 = $"Buttons/1-1"
@onready var _1_2 = $"Buttons/1-2"
@onready var _1_3 = $"Buttons/1-3"
@onready var _2_1 = $"Buttons/2-1"
@onready var _3_1 = $"Buttons/3-1"
@onready var _3_2 = $"Buttons/3-2"
@onready var _3_3 = $"Buttons/3-3"
@onready var _4_1 = $"Buttons/4-1"
@onready var _4_2 = $"Buttons/4-2"
@onready var _4_3 = $"Buttons/4-3"
@onready var _5_1 = $"Buttons/5-1"
@onready var _5_2 = $"Buttons/5-2"
@onready var _5_3 = $"Buttons/5-3"
@onready var control = $Buttons
const Levels : GDScript = preload("res://scenes/levels/Transition/Levels.gd")
@onready var boss = $Buttons/BOSS
@onready var transition = $Transition


# Called when the node enters the scene tree for the first time.
func _ready():
	#Manager.Level1_1 = true
	#Manager.save_game()
	Manager.load_game()
	#print(Manager.Level1_1)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	match Manager.Level1_1:
		true:
			_1_1.disabled = false
			_1_1.update()
		false:
			_1_1.disabled = true
			_1_1.update()
	
	match Manager.Level1_2:
		true:
			_1_2.disabled = false
			_1_2.update()
		false:
			_1_2.disabled = true
			_1_2.update()
	
	match Manager.Level1_3:
		true:
			_1_3.disabled = false
			_1_3.update()
		false:
			_1_3.disabled = true
			_1_3.update()
			
	match Manager.Level2_1:
		true:
			_2_1.disabled = false
			_2_1.update()
		false:
			_2_1.disabled = true
			_2_1.update()
	
	match Manager.Level3_1:
		true:
			_3_1.disabled = false
			_3_1.update()
		false:
			_3_1.disabled = true
			_3_1.update()
	
	match Manager.Level3_2:
		true:
			_3_2.disabled = false
			_3_2.update()
		false:
			_3_2.disabled = true
			_3_2.update()
	
	match Manager.Level3_3:
		true:
			_3_3.disabled = false
			_3_3.update()
		false:
			_3_3.disabled = true
			_3_3.update()
			
	match Manager.Level4_1:
		true:
			_4_1.disabled = false
			_4_1.update()
		false:
			_4_1.disabled = true
			_4_1.update()
	
	match Manager.Level4_2:
		true:
			_4_2.disabled = false
			_4_2.update()
		false:
			_4_2.disabled = true
			_4_2.update()
		
	match Manager.Level4_3:
		true:
			_4_3.disabled = false
			_4_3.update()
		false:
			_4_3.disabled = true
			_4_3.update()
	
	match Manager.Level5_1:
		true:
			_5_1.disabled = false
			_5_1.update()
		false:
			_5_1.disabled = true
			_5_1.update()
	
	match Manager.Level5_2:
		true:
			_5_2.disabled = false
			_5_2.update()
		false:
			_5_2.disabled = true
			_5_2.update()
			
	match Manager.Level5_3:
		true:
			_5_3.disabled = false
			_5_3.update()
		false:
			_5_3.disabled = true
			_5_3.update()
		
	match Manager.Level6_66:
		true:
			boss.disabled = false
			#boss.update()
		false:
			boss.disabled = true
			#boss.update()
	



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


func _on_back_pressed():
	var tutorial = load("res://scenes/levels/TitleScreen/intro_cinematic.tscn")
	transition.transition_to(tutorial)


func _on_reset_progress_pressed():
	Manager.reset_progress()
	
