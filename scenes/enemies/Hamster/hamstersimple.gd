extends AnimatedSprite2D
@export var hide : bool 
@onready var dialogbox = $DialogBox

@onready var player_detector = $PlayerDetector
@onready var hamster_bug : HamsterRagdoll = $"../Hamster-bug"


# Called when the node enters the scene tree for the first time.
func _ready():
	if hide == true:
		visible  = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_detector_body_entered(body):
	if body is SlimePlayer:
		if dialogbox != null:
			player_detector.queue_free()
			dialogbox.InputSTOP = false
			dialogbox.clearcenter()
			dialogbox.linecount = 1
			play("Hidden")
			hamster_bug.visible = true
			hamster_bug.ragdoll_throw()
