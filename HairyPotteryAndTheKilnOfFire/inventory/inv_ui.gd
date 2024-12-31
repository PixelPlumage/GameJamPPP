extends Control
class_name InvUI

var slots: Array
@onready var slotsContainer = $GridContainer
@onready var slot_ui = preload("res://inventory/inv_ui_slot.tscn")

var is_open: bool = false

func _ready() -> void:
	SignalBus.updateInv.connect(update_slots)
	SignalBus.swapItems.connect(swap_slots)
	for slot in Global.playerData.inv.slots:
		var newSlot = slot_ui.instantiate()
		slotsContainer.add_child(newSlot)
	slots = slotsContainer.get_children()	
	close()

func update_slots() -> void:
	for i in range(min(Global.playerData.inv.slots.size(), slots.size())):
		slots[i].update(Global.playerData.inv.slots[i])

func swap_slots(slot1, slot2) -> void:
	var firstIndex = slots.find(slot1)
	var secondIndex = slots.find(slot2)
	var tempFirstSlot = Global.playerData.inv.slots[firstIndex].duplicate()
	Global.playerData.inv.slots[firstIndex] = Global.playerData.inv.slots[secondIndex].duplicate()
	Global.playerData.inv.slots[secondIndex] = tempFirstSlot
	SignalBus.updateInv.emit()
	
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
