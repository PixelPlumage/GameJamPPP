extends Resource
class_name PlayerData

@export var speed: float = 100.0
@export var health: int = 100

@export var money: int = 500
@export var bagSize: int = 32
@export var SavePos: Vector2


@export var inv: Inv

func _init() -> void:
	inv = Inv.new()
	inv.slots.resize(bagSize)
	for i in bagSize:
		inv.slots[i] = InvSlot.new()

func change_health(value: int) -> void:
	health += value
	
func UpdatePos(value: Vector2) -> void:
	SavePos = value
	
func update_money(value: int) -> void:
	money += value
