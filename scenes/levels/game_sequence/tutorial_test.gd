extends Node2D
@onready var static_body_2d = $"../../StaticBody2D"
@onready var camera_2d = $Camera2D
@export var Tutorial : bool 
@onready var transition : TransitionScene = $"../../Transition"
@onready var animation = $AnimationPlayer
@onready var player : SlimePlayer = $".."
@onready var color_rect = $ColorRect
@onready var dialog : DialogComponent = $"../../StaticBody2D/Hamsterzote/DialogBox"
@onready var frozen = $"../../Boxes/Frozen"


func _ready():
	match Tutorial:
		true:
			pass
			
			
		false:
			var boxes = frozen.get_children()
			for box : ObjectClass in boxes:
				box.freeze = false
			static_body_2d.queue_free()
			camera_2d.queue_free()
			color_rect.queue_free()
			
			
			
			

func _process(delta):
	if dialog != null:
		match dialog.linecount:
			3:
				dialog.show_end = false
				player.set_physics_process(true)
				dialog.InputSTOP = true
				if Input.is_action_just_pressed("ui_right"):
					dialog.clearcenter()
			4:
				dialog.show_end = true
				dialog.InputSTOP = false
			5:
				dialog.show_end = false
				dialog.InputSTOP = true

func _on_transition_opendone():
	if Tutorial == true:
		print("CameraDone")
		player.sprite.play("Idle")
		player.set_physics_process(false)
		camera_2d.enabled = true
		camera_2d.make_current()
		animation.play("FadeOut")
