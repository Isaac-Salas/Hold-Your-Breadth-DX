extends Node2D
class_name RigidSkeleton
@export var skeleton : Skeleton2D
@onready var rigids : Array[RigidBody2D]
@onready var bones : Array[Node]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if skeleton != null:
		var tree : SceneTree = skeleton.get_tree()
		bones = tree.get_nodes_in_group("Bones")
		for bone : Bone2D in bones:
			var newbody : RigidBody2D = RigidBody2D.new()
			newbody.position = to_local(bone.global_position)
			newbody.name = str(bone.name) + "Rigid"
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
	for i in rigids.size():
		pass
