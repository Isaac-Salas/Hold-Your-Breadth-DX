extends Node2D
class_name ResetTooltip
@onready var timer: Timer = $Timer
@onready var blink: AnimationPlayer = $NewTools/Blink
@onready var new_tools: AnimatedSprite2D = $NewTools
@export var active : bool = true

func _ready() -> void:
	if active == true:
		timer.start()


func _on_timer_timeout() -> void:
	if active == true:
		#print("Show tooltip NOW")
		blink.play("BlinkLoop")
		new_tools.visible = true
		new_tools.play("Reset")
		timer.start()


func _on_slime_grab(value: Variant) -> void:
	reset_timer(value)


func _on_slime_jump(value: Variant) -> void:
	reset_timer(value)


func _on_slime_movement(value: Variant) -> void:
	reset_timer(value)


func _on_slime_throw(value: Variant) -> void:
	reset_timer(value)


func reset_timer(value : bool):
	#print(timer.time_left)
	match value:
		true:
			if active == true:
				print("Resetting")
				timer.start()
				blink.stop()
				new_tools.visible = false
			else:
				timer.stop()
		false:
			pass
