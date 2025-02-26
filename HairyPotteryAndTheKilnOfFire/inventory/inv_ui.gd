extends Control
class_name InvUI

var slots: Array
@onready var slotsContainer = $GridContainer
@onready var slot_ui = preload("res://inventory/inv_ui_slot.tscn")

var is_open: bool = false

func _ready() -> void:
	SignalBus.updateInv.connect(update_slots)
	SignalBus.openInv.connect(open)
	#SignalBus.swapItems.connect(swap_slots)
	for slot in Global.gameState.playerData.inv.slots:
		var newSlot = slot_ui.instantiate()
		slotsContainer.add_child(newSlot)
	slots = slotsContainer.get_children()
	update_slots()
	close()

func update_slots() -> void:
	for i in range(min(Global.gameState.playerData.inv.slots.size(), slots.size())):
		slots[i].update(Global.gameState.playerData.inv.slots[i])

#func swap_slots(slot1, slot2) -> void:
	#var firstIndex = Global.gameState.playerData.inv.slots.find(slot1)
	#var secondIndex = Global.gameState.playerData.inv.slots.find(slot2)
	#var tempFirstSlot = slot1.duplicate()
	#Global.gameState.playerData.inv.slots[firstIndex] = slot2.duplicate()
	#Global.gameState.playerData.inv.slots[secondIndex] = tempFirstSlot
	#SignalBus.updateInv.emit()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("i"):
		if is_open:
			close()
		else:
			open()

func open():
	visible = true
	is_open = true
	
func close():
	visible = false
	is_open = false
