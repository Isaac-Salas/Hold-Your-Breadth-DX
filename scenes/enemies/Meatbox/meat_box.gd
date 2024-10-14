extends RigidBody2D
var picked = false
var start = true
var count = false
@onready var timerst = $Timer
@onready var sprite_2d = $Sprite2D
@onready var colision = $CollisionShape2D
@onready var animation_player = $AnimationPlayer
@onready var player : SlimePlayer
@export var Lastingtime = 6.0
@onready var spawner_component = $SpawnerComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(picked, count)
	player = get_tree().get_first_node_in_group("Player")
	
	if player:
		if picked == true and count == true:
			timer()
			animation_player.speed_scale = (6.0/Lastingtime)
			animation_player.play("blink")
			#print(timerst.time_left))
			colision.scale = player.colision.scale
			sprite_2d.scale = colision.scale




func reset():
		colision.scale = Vector2(1,1)
		sprite_2d.scale = Vector2(1,1)
		count = false
		picked = false
		#set_disable_scale(true)
		



func timer():
	if start == true:
		timerst.start(Lastingtime)
		start = false
		

func _on_body_entered(body):
	if picked == true:
		print(body.name)
		count = true


func _on_timer_timeout():
	animation_player.stop()
	animation_player.play("RESET")
	reset()
