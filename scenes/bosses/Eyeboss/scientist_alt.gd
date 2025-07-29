extends Node2D
class_name ScientistAlt
@export var freeze_hip : bool = true
@export var freeze_chest : bool = true
@export var freeze_head : bool = false
@onready var hip_2: PhysicalBone2D = $Skeleton2D/Hip2
@onready var chest: PhysicalBone2D = $Skeleton2D/Hip2/Chest
@onready var head: PhysicalBone2D = $Skeleton2D/Hip2/Chest/Head
@export var disappear_screen : bool = false


@onready var skeleton_2d: Skeleton2D = $Skeleton2D

func freeze_check(cond : bool , bone : PhysicalBone2D):
	if cond == true:
		bone.lock_rotation = true
	else:
		bone.lock_rotation = false


func _ready()->void:
	freeze_check(freeze_hip,hip_2)
	freeze_check(freeze_chest, chest)
	freeze_check(freeze_head, head)
	
	var modification_stack: SkeletonModificationStack2D = skeleton_2d.get_modification_stack()
	# Better to enable it at runtime as it makes it harder to interact with in the editor when on
	modification_stack.enabled = true
	
	var modification_physical_bones = modification_stack.get_modification(0)
	modification_physical_bones.enabled = true
	
	fix_skeleton(skeleton_2d)
	
	modification_physical_bones.fetch_physical_bones()
	# this will enable simulate_physics on all bones
	modification_physical_bones.start_simulation()
	
	# if you call stop_simulation() then start_simulation() again it will break until you freeze and unfreeze each bone
	modification_physical_bones.stop_simulation()
	modification_physical_bones.start_simulation()
	fix_skeleton(skeleton_2d)

func fix_skeleton(target: Skeleton2D):
	for child in target.get_children():
		if child is PhysicalBone2D:
			call_child_recursive(child, update_bone)

func call_child_recursive(node: Node2D, f: Callable):
	f.call(node)
	for child in node.get_children():
		call_child_recursive(child, f)

func update_bone(bone: Node2D):
	if bone is PhysicalBone2D:
		if !bone.simulate_physics:
			# there might be yet another bug regarding the resulting position of bone and its children after enabling simulate_physics
			# recommended to check it in the editor and ensure the position is correct
			print("warning: " + bone.name + " simulate_physics is not checked!")
		# this will undo the cpp constructor
		bone.freeze = true
		bone.freeze = false


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if disappear_screen == true:
		self.queue_free()
