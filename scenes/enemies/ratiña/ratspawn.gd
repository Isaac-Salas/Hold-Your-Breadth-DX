extends Node2D
class_name RatSpawn
@onready var hole_anim = $HoleAnim

@onready var spawn_cooldown = $SpawnCooldown
@onready var spawner : SpawnerComponent = $SpawnerComponent
@export var Rat_number : int
@export var Fleemarker : RatFleeMarker
# Called when the node enters the scene tree for the first time.
func _ready():
	hole_anim.play("Idle")


func reset():
	hole_anim.play("Idle")
	spawn_cooldown.start(2)

func _on_timer_timeout():
	for rat in Rat_number:
		print("Tryspawnrat!!!")
		await hole_anim.animation_looped
		var RATA = load("res://scenes/enemies/ratiña/ratiña.tscn")
		spawner.scene = RATA
		var newrat : Rat_enemy = spawner.spawn()
		newrat.ratfleetarget = Fleemarker
		newrat.spawnedfrom = self
		hole_anim.play("Spawned")
		spawn_cooldown.stop()
