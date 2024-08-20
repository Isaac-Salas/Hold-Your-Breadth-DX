extends Node2D

@onready var transition: Node2D = $Transition

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	transition.ap.play("Opening")
