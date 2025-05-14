extends RichTextLabel
class_name DialogComponent
@export var InputEnable : bool = true
@export var InputSTOP : bool = false
@export var Timerstart : bool = false
@export var linecount : int = 0
@export var Typetime : float = 0
@export var Quickypetime : float = 0
@export var Dialog : PackedStringArray
@onready var extraevent : bool = true
@onready var animated_sprite_2d = $Control/AnimatedSprite2D
@export var show_end : bool
@onready var charcount : int = 0
@onready var timer = $Timer
@onready var count : int = 0 
signal Done()
@onready var dumbdone : bool
@onready var audio_stream_player = $AudioStreamPlayer
@onready var bell = $Bell


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = Typetime
	if Timerstart == true:
		timer.start()
	


func _input(event):
	if InputSTOP == false:
		if InputEnable == true:
			if Input.is_action_pressed("OK"):
				if linecount < (Dialog.size() - 1):
					clearcenter()
					
	if Input.is_action_just_pressed("OK"):
			timer.wait_time = Quickypetime
	if Input.is_action_just_released("OK"):
			timer.wait_time = Typetime


func clearcenter():
	animated_sprite_2d.visible = false
	count = 0
	linecount += 1
	charcount = 0
	InputEnable = false
	dumbdone = false
	self.clear()
	self.append_text("[center][center]")

func _on_timer_timeout():
	var textoide : String = Dialog[linecount]
	if charcount < textoide.length():
		InputEnable = false
		self.append_text(textoide[charcount])
		audio_stream_player.pitch_scale = randf_range(1.0, 2.5)
		audio_stream_player.play()
		charcount += 1
	if charcount == textoide.length():
		if count < 1:
			print("done")
			count += 1
			InputEnable = true
			Done.emit()
			bell.pitch_scale = randf_range(1.0, 1.5)
			bell.play()
		


func _on_done():
	dumbdone = true
	if show_end == true:
		animated_sprite_2d.visible = true
	
