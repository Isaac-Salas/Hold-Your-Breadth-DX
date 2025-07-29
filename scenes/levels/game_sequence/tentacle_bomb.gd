extends Node2D

class_name TentacleBomb
@export var screen_activator : bool = false
@export var tentacle_amount : int = 10
@export var rotation_amount : int = 10 

@export var animation_speed : float = 0.1
@export var punto_cent: Node2D
@export var random_lenghts : bool = true
@export var color_variation : bool = false
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var positions_array : Array[Vector2]

@export var base_color : Color = Color(.48,.19,.20,0.8)
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

const ROPE_MODULAR = preload("res://scenes/objects/rope_modular.tscn")
var tentacle_tween : Tween


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_2d !=null and ray_cast_2d.rotation_degrees < 360.0:
		ray_cast_2d.rotation_degrees += rotation_amount
		positions_array.append(ray_cast_2d.get_collision_point())
		#print(ray_cast_2d.get_collision_point())
	elif ray_cast_2d != null and screen_activator == false :
		generate_tentacle(tentacle_amount,positions_array)
		ray_cast_2d.queue_free()
		
	
	
func generate_tentacle(tentacles_amount : int, pos_array : Array[Vector2]):
	var count : int = 0
	var rand_index_array : Array  =  get_random_numbers(0,positions_array.size()-1)
	for tentacle in tentacles_amount:
		var rand_index : int = rand_index_array[count]
		var pos_rand : Vector2 = positions_array[rand_index]
		var marker_cent : Marker2D = Marker2D.new()
		var selected_pos = to_local(pos_rand)
		self.add_child(marker_cent)
		var new_rope : StringComponent = ROPE_MODULAR.instantiate()
		if punto_cent != null:
			new_rope.puntocent = punto_cent
		else:
			new_rope.puntocent = self
		new_rope.light = marker_cent
		if random_lenghts == true:
			new_rope.ropeLength = randf_range(15.0, 60.0)
		if color_variation == true:
			var new_color : Color = base_color
			new_color.r -= randf_range(0.0,0.5)
			new_rope.color_override = new_color
		else:
			new_rope.color_override = base_color
		self.add_child(new_rope)
		animate_tentacle(marker_cent,selected_pos,animation_speed)
		await tentacle_tween.finished
		count += 1
	#print(count)
	
func get_random_numbers(from : int , to : int):
	var arr = []
	for i in range(from, to):
		arr.shuffle()
		arr.append(i)
	#print(arr)
	return arr

func animate_tentacle(target : Marker2D, final_pos : Vector2, duration : float = 1.0):
	reset_anim()
	tentacle_tween.tween_property(target, "position", final_pos ,duration)




func reset_anim():
	if tentacle_tween:
		tentacle_tween.kill()
	tentacle_tween = create_tween()


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	if screen_activator == true:
		generate_tentacle(tentacle_amount,positions_array)
		ray_cast_2d.queue_free()
		visible_on_screen_notifier_2d.queue_free()
		
