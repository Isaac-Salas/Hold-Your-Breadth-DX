extends GPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func goop_check(value: bool) -> void:
	if value == true:
		#print("gooping")
		emitting = true
	else:
		#print("Stopping goop")
		emitting = false


func _on_slime_movement(value: Variant) -> void:
	goop_check(value)


func _on_slime_jump(value: Variant) -> void:
	goop_check(value)
