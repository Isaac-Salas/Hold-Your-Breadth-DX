extends AudioStreamPlayer2D
class_name PlayerSFX

@export var Player : SlimePlayer

const JUMP = preload("res://assets/audioshit/jump.mp3")
const WALK_CYCLE = preload("res://assets/audioshit/walk-cycle.mp3")
#Movement clean
var startcountM = 0
var stopcountM = 0

#JumpClean
var startcountJ = 0
var stopcountJ = 0

signal Unpressed



func _on_character_body_2d_grab(value):
	match value:
		true:
			pass
		false:
			pass


func _on_character_body_2d_jump(value):
	if value:
		pitch_scale = randf_range(0.75, 1.25)
		stream = JUMP
		play()


func _on_character_body_2d_movement(value):
	match value:
		true:
			startcountM += 1
			if startcountM <= 1:
				#print("Walk SFX")
				pitch_scale = randf_range(0.2, 1.8)
				stream = WALK_CYCLE
				play()
				stopcountM = 0
		false:
			stopcountM += 1
			if stopcountM <= 1:
				#print("Walk SFX STOP")
				stop()
				startcountM = 0


func _on_character_body_2d_throw(value):
	pass # Replace with function body.
