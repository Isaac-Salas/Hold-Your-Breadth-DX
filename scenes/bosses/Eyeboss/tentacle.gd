extends Node2D
@export var player : SlimePlayer
@onready var segment_4_2: Bone2D = $"Anchor/Skeleton2D/Central/Segment1-1/Segment1-2/Segment2-1/Segment2-2/Segment3-1/Segment3-2/Segment4-1/Segment4-2"
@onready var tip: Bone2D = $"Anchor/Skeleton2D/Central/Segment1-1/Segment1-2/Segment2-1/Segment2-2/Segment3-1/Segment3-2/Segment4-1/Segment4-2/Tip"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
