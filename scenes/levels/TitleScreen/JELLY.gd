extends Control
@onready var atras = $Label3/Atras

var previousfovcus
@onready var jelly_dog = $"../Label2/JellyDOG"


func checkvisible():
	if visible == true:
		atras.grab_focus()
	else:
		jelly_dog.grab_focus()
