extends Node2D
class_name ButtonCable

@export var startMarker: Marker2D
@export var middleMarker1: Marker2D
@export var middleMarker2: Marker2D
@export var endMarker : Marker2D
@export var ropeLength : float  = 30
@export var color : Color
@export var constrain : float = 1	# distance between points
@export var gravity : Vector2 = Vector2(0,9.8)
@export var dampening : float = 0.9
@export var startPin : bool = true
@export var endPin : bool = true


const SPAWNED_RIGID = preload("res://scenes/verlet/SpawnedRigid.tscn")
@onready var line2D: = $Line2D

var pos: PackedVector2Array
var posPrev: PackedVector2Array
var pointCount: int

func _ready()->void:

	pointCount = get_pointCount(ropeLength)
	line2D.default_color = color
	resize_arrays()
	init_position()
	
	if startMarker != null:
		set_start(startMarker.global_position)
	if endMarker != null:
		set_last(endMarker.global_position)
	
func spawnphysics ():
	var counter : int = 0
	for points in line2D.points:
		counter += 1
		if counter == 5:
			var newphy : RigidSegment = SPAWNED_RIGID.instantiate()
			newphy.point_to_follow = points
			add_child(newphy)

func get_pointCount(distance: float)->int:
	return int(ceil(distance / constrain))

func resize_arrays():
	pos.resize(pointCount)
	posPrev.resize(pointCount)

func init_position()->void:
	for i in range(pointCount):
		pos[i] = position + Vector2(constrain *i, 0)
		posPrev[i] = position + Vector2(constrain *i, 0)
	position = Vector2.ZERO

func _process(delta)->void:
	update_points(delta)
	update_constrain()
	spawnphysics()
	if middleMarker1 != null:
		set_middle1(middleMarker1.global_position)
	if middleMarker2 != null:
		set_middle2(middleMarker2.global_position)
	
	#update_constrain()	#Repeat to get tighter rope
	#update_constrain()
	
	# Send positions to Line2D for drawing
	line2D.points = pos

func set_start(p:Vector2)->void:
	pos[0] = p
	posPrev[0] = p
	

func set_middle1(p:Vector2)->void:
	pos[(pointCount/3)] = p
	posPrev[(pointCount/3)] = p
	
func set_middle2(p:Vector2)->void:
	pos[(pointCount/3)*2] = p
	posPrev[(pointCount/3)*2] = p

func set_last(p:Vector2)->void:
	pos[pointCount-1] = p
	posPrev[pointCount-1] = p

func update_points(delta)->void:
	for i in range (pointCount):
		# not first and last || first if not pinned || last if not pinned
		if (i!=0 && i!=pointCount-1) || (i==0 && !startPin) || (i==pointCount-1 && !endPin):
			var velocity = (pos[i] -posPrev[i]) * dampening
			posPrev[i] = pos[i]
			pos[i] += velocity + (gravity * delta)

func update_constrain()->void:
	for i in range(pointCount):
		if i == pointCount-1:
			return
		var distance = pos[i].distance_to(pos[i+1])
		var difference = constrain - distance
		var percent = difference / distance
		var vec2 = pos[i+1] - pos[i]
		
		# if first point
		if i == 0:
			if startPin:
				pos[i+1] += vec2 * percent
			else:
				pos[i] -= vec2 * (percent/2)
				pos[i+1] += vec2 * (percent/2)
		# if last point, skip because no more points after it
		elif i == pointCount-1:
			pass
		# all the rest
		else:
			if i+1 == pointCount-1 && endPin:
				pos[i] -= vec2 * percent
			else:
				pos[i] -= vec2 * (percent/2)
				pos[i+1] += vec2 * (percent/2)
