extends Control
class_name StorageUI

@onready var slot_ui = preload("res://inventory/inv_ui_slot.tscn")
@onready var itemContainer = $StorageContainer/ItemContainer
@onready var slots

func _ready() -> void:
	SignalBus.updateStorage.connect(update_storage)
	for i in max(Global.storage.size(),Global.MIN_STORAGE):
		var newSlot = slot_ui.instantiate()
		newSlot.stored = true
		itemContainer.add_child(newSlot)
	slots = itemContainer.get_children()
	update_storage()

func update_storage():
	for i in Global.storage.size():
		slots[i].update(Global.storage[i])
		
