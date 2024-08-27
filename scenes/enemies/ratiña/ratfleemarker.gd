extends Marker2D

@onready var player : SlimePlayer
var cancatch = false
var catched = false
var catchedrats : Array = []
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("Player")
	player.scare.connect(catch)




func catch():
	#print("Changingcatch")
	cancatch = true


func _on_area_2d_body_entered(body):
	if cancatch == true and body is Rat_enemy:
		catched = true
		print("catching")
		catchedrats.append(body)
		for rat in catchedrats:
			rat.set_deferred("freeze", true)
			rat.global_position = self.global_position
		timer.start(0.2)


func _on_timer_timeout():
	for rat in catchedrats:
		rat.set_deferred("freeze", false)
	catchedrats = []
