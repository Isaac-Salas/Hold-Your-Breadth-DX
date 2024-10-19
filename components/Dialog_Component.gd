extends RichTextLabel
class_name DialogComponent
@export var InputEnable : bool = true
@export var linecount : int = 0
@export var Typetime : float = 0
@export var Quickypetime : float = 0
@export var Dialog : PackedStringArray
@onready var extraevent : bool = true
@onready var InputSTOP : bool = false
@onready var charcount : int = 0
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = Typetime
	


func _input(event):
	if InputSTOP == false:
		if InputEnable == true:
			if Input.is_anything_pressed():
				if linecount < (Dialog.size() - 1):
					clearcenter()
					linecount += 1
					charcount = 0
	if Input.is_action_just_pressed("OK"):
			timer.wait_time = Quickypetime
	if Input.is_action_just_released("OK"):
			timer.wait_time = Typetime


func clearcenter():
	self.clear()
	self.append_text("[center][center]")

func _on_timer_timeout():
	var textoide : String = Dialog[linecount]
	if charcount < textoide.length():
		InputEnable = false
		self.append_text(textoide[charcount])
		charcount += 1
	if charcount == textoide.length():
		InputEnable = true
		
