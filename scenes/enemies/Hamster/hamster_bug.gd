extends RigidBody2D

class_name HamsterRagdoll
@onready var ham_rigid : RigidBody2D = self
@export var ForceVector : Vector2
@export var RotateVal : float


func ragdoll_throw():
	ham_rigid.set_deferred("freeze", false)
	ham_rigid.set_deferred( "lock_rotation", false)
	ham_rigid.linear_velocity += ForceVector
	ham_rigid.rotate(RotateVal)
