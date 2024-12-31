extends Resource
class_name PlayerData

@export var speed: float = 100.0
@export var health: int = 100

@export var money: int = 500
@export var bagSize: int = 32
@export var SavePos: Vector2

var selectedSlot = 0:
	get:
		return selectedSlot
	set(newSlot):
		var oldSlot = selectedSlot
		selectedSlot = newSlot
		SignalBus.selectedSlotChanged.emit(oldSlot, selectedSlot)
		

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
	
func update_selected(up: bool) -> void:
	var oldSelected = selectedSlot
	if up:
		selectedSlot = (selectedSlot + 1) % 8
	else:
		if selectedSlot == 0:
			selectedSlot = 7
		else:
			selectedSlot -= 1
