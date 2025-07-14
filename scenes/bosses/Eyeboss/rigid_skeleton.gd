extends Node2D
class_name RigidSkeleton
@export var skeleton : Skeleton2D
@onready var rigids : Array[RigidBody2D]
@onready var bones : Array[Node]
@onready var children : Array[RigidBody2D]
@export var ragdoll : bool 
@export var root : Node2D
@onready var scientist: Scientist = $"../.."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if ragdoll == true:
		if skeleton != null:
			generate_skelly()
			generate_joints(rigids)
		else:
			var tree : SceneTree = self.get_tree()
			bones = tree.get_nodes_in_group("Bones")
			var buffchildren = get_children()
			for child in buffchildren:
				if child is RigidBody2D:
					children.append(child)



func generate_joints(array : Array[RigidBody2D]):
	for body : RigidBody2D in array:
		var closest : RigidBody2D = find_closest_to(body, array)
		var newjoint : PinJoint2D = PinJoint2D.new()
		newjoint.position = closest.position - body.position
		self.add_child.call_deferred(newjoint)

func find_closest_to(node: Node2D, others: Array):
	var A = node
	var min_distance = 99999999.0;
	var closest_object = null;

	for B in others : #{
		if B == A : 
			continue
		var dist = A.get_global_transform().origin.distance_to( B.get_global_transform().origin )
		if dist < min_distance : 
			min_distance = dist 
			closest_object = B;
	
	return closest_object


func generate_skelly():
	if skeleton != null:
		var tree : SceneTree = skeleton.get_tree()
		bones = tree.get_nodes_in_group("Bones")
		for bone : Bone2D in bones:
			var newbody : RigidBody2D = RigidBody2D.new()
			newbody.position = to_local(bone.global_position)
			newbody.name = str(bone.name) + "Rigid"
			newbody.set_collision_layer_value(1, false)
			newbody.set_collision_mask_value(1, false)
			newbody.set_collision_layer_value(2, true)
			newbody.set_collision_mask_value(2, true)
			#newbody.freeze = true
			self.add_child.call_deferred(newbody)
			var newcollision : CollisionShape2D = CollisionShape2D.new()
			var newshape : CircleShape2D = CircleShape2D.new()
			newshape.radius = 3.0
			newcollision.shape = newshape
			newbody.add_child.call_deferred(newcollision)
			rigids.append(newbody)
			
			print(newbody.global_position)
		print(rigids)
			
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ragdoll == true:
		if skeleton != null:
			for i in rigids.size():
				bones[i].global_transform = rigids[i].global_transform
		else:
				for i in children.size():
					bones[i].global_transform = children[i].global_transform
