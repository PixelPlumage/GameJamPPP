extends Resource

class_name InvItem

@export var name: String = ""
@export var id: int
@export var texture: Texture2D
@export var value: int
@export var cost: int
@export var tooltip: String

func _to_string() -> String:
	return "Item Name: " + name
