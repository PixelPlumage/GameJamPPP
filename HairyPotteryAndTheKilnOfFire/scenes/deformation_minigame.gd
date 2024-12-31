extends Node2D

@onready var root_bone: Bone2D = $Node/Skeleton2D/Bone2D11

var morphDir: Vector2
var morph: bool = false
var morphVelocity: Vector2
var morphBone: Node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if morphBone:
		print("moving bone")
		morphBone.position += morphVelocity * delta * 0.1
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			print("button pressed")
			print(root_bone.get_children().size())
			morphBone = find_nearest_bone(root_bone.get_children())
		elif event.is_released():
			morphBone = null
	if event is InputEventMouseMotion:	
		morphVelocity = event.velocity

func find_nearest_bone(bones: Array[Node]) -> Node:
	var mousePos = get_global_mouse_position()
	var closestBone: Node
	var shortestDist: float = mousePos.distance_to(bones[0].global_position)
	for bone in bones:
		var curDist = mousePos.distance_to(bone.global_position)
		if curDist < shortestDist:
			closestBone = bone
			shortestDist = curDist
		pass
	return closestBone
