extends Timer

@onready var swinging_eye_2: SwingingEye = $"../SwingingEye2"
@onready var swinging_eye_3: SwingingEye = $"../SwingingEye3"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timeout() -> void:
	swinging_eye_2.hang_activate()
	swinging_eye_3.hang_activate()
