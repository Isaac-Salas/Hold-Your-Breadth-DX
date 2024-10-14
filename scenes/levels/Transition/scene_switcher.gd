extends Node2D
const CHASE = preload("res://scenes/levels/game_sequence/Chase.tscn")
const RATESTING = preload("res://scenes/levels/rats/ratesting.tscn")
const SCALE_LVL = preload("res://scenes/levels/game_sequence/scale_lvl.tscn")
const TEMPLATE = preload("res://scenes/objects/templaete.tscn")
const TESTING = preload("res://scenes/levels/Testing/testing.tscn")
const TUTORIAL_LEVEL = preload("res://scenes/levels/game_sequence/Tutorial_Level.tscn")
var i = 0
@onready var spawner_component = $SpawnerComponent
var new
var arrayass = [CHASE,RATESTING,SCALE_LVL,TEMPLATE,TESTING,TUTORIAL_LEVEL]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("SwitchScene"):
		$Label.visible = false
		if new:
			new.queue_free()
			spawner_component.scene = arrayass[i]
			new = spawner_component.spawn()
		else:
			spawner_component.scene = arrayass[i]
			new = spawner_component.spawn()
		
		if i<5:
			i += 1
		else:
			i=0



	
