extends Resource
class_name PlayerData

@export var speed: float = 100.0
@export var health: int = 100

@export var SavePos: Vector2

@export var inv: Inv

func _init() -> void:
	inv = Inv.new()
	inv.slots.resize(12)
	for i in 12:
		inv.slots[i] = InvSlot.new()

func change_health(value: int) -> void:
	health += value
	
func UpdatePos(value: Vector2) -> void:
	SavePos = value
