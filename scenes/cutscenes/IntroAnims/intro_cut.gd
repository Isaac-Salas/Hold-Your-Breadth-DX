extends Node2D
@onready var fondo = $Fondo
@onready var slime = $Slime
@onready var light = $"Swing-light/Light"
@onready var line_2d = $"Swing-light/String/Line2D"
@onready var animcount : int = 0
@onready var click : bool = true
@onready var dialog_box = $ColorRect/GridContainer/DialogBox
@onready var currentanim : String
@onready var point_light_2d = $"Swing-light/Light/PointLight2D"
@onready var transition = $Transition


# Called when the node enters the scene tree for the first time.
func _ready():
	dialog_box.timer.start()
	line_2d.width = 2
	light.position.y -= 300


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if click == true:
		if Input.is_anything_pressed():
			#print("click")
			print(dialog_box.linecount)
			match dialog_box.linecount:
				
				1:
					dialog_box.InputSTOP = true
					dialog_box.timer.start()
					fondo.play("Inicio")
					slime.play("Inicio")
				2:
					#dialog_box.InputSTOP = true
					#dialog_box.InputSTOP = true
					slime.play("Despertar")
					click = false
					
				3:
					#dialog_box.InputSTOP = true
					slime.play("Tarjeta")
					fondo.play("Tarjeta")

					#dialog_box.InputSTOP = true
				4:
					#dialog_box.InputSTOP = true
					slime.play("Look")
					fondo.play("Look")
				5:
					pass
					#dialog_box.InputSTOP = true
					#
				6:
					transition.transition_to()
					

func _on_slime_animation_finished():
	if slime.animation == "Inicio":
		slime.play("Dormido")
		dialog_box.InputSTOP = false
		click = true
		
	if slime.animation == "Despertar":
		slime.play("Loop")
		click = false

	if slime.animation == "Tarjeta":
		fondo.play("Tarjeta-S")
		slime.play("Tarjeta-S")
		click = false

	if slime.animation == "Look":
		slime.play("Look-S")
		click = false


func _on_fondo_animation_finished():
	if fondo.animation == "Inicio":
		fondo.play("Dormido")


func _on_dialog_box_done():
	click = true # Replace with function body.
