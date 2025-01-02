extends Control
class_name StorageUI

@onready var slot_ui = preload("res://inventory/inv_ui_slot.tscn")
@onready var itemContainer = $StorageContainer/ItemContainer
@onready var slots

func _ready() -> void:
	SignalBus.updateStorage.connect(update_storage)
	for i in max(Global.gameState.storage.size(),Global.MIN_STORAGE):
		var newSlot = slot_ui.instantiate()
		newSlot.stored = true
		itemContainer.add_child(newSlot)
	slots = itemContainer.get_children()
	print("setup sotrage")
	update_storage()

func update_storage():
	for i in Global.gameState.storage.size():
		slots[i].update(Global.gameState.storage[i])
		
