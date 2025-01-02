extends Panel

@onready var hoverArea = $HoverArea
@onready var item_visuals: Sprite2D = $HoverArea/ItemContainer/Panel/item_display
@onready var amount_text: Label = $HoverArea/ItemContainer/Panel/Label
@onready var itemContainer = $HoverArea/ItemContainer
@export var locked = false
@export var stored = false
var invSlot
var is_dragging: bool = false
var original_position

var targets: Array[Node] = []

func update(slot: InvSlot):
	invSlot = slot
	if slot.count <= 0:
		slot.item = null
	if !slot.item:
		item_visuals.visible = false
		amount_text.visible = false
	else:
		item_visuals.visible = true
		item_visuals.texture = slot.item.texture
		if slot.count > 1:
			amount_text.visible = true
			amount_text.text = str(slot.count)
		else:
			amount_text.visible = false
			amount_text.text = str(slot.count)
		itemContainer.tooltip_text = slot.item.tooltip

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if locked:
			return
		if event.button_index == MOUSE_BUTTON_RIGHT and event.is_released():
			if Global.is_storage_open:
				if invSlot.stored:
					if invSlot.item != null:
						var foundSlotIndex = find_matching_item(Global.gameState.playerData.inv.slots)
						if foundSlotIndex >= 0:
							Global.gameState.playerData.inv.slots[foundSlotIndex].count += 1
							invSlot.count -= 1
						else:
							var emptyslots = Global.gameState.playerData.inv.slots.filter(func(slot): return slot.item == null)
							if !emptyslots.is_empty():
								emptyslots[0].item = invSlot.item
								emptyslots[0].count = 1
								invSlot.count -= 1
				else:
					if invSlot.item != null:
						var foundSlotIndex = find_matching_item(Global.gameState.storage)
						if foundSlotIndex >= 0:
							Global.gameState.storage[foundSlotIndex].count += 1
							invSlot.count -= 1
						else:
							var emptyslots = Global.gameState.storage.filter(func(slot): return slot.item == null)
							if !emptyslots.is_empty():
								emptyslots[0].item = invSlot.item
								emptyslots[0].count = 1
								invSlot.count -= 1
					pass
			SignalBus.updateInv.emit()
			SignalBus.updateStorage.emit()
			return
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				is_dragging = true
				original_position = hoverArea.global_position
				#hoverArea.top_level = true
				hoverArea.z_index = 2
			else:
				if targets.size() > 0:
					SignalBus.swapItems.emit(self.invSlot, targets.back().invSlot)
				is_dragging = false
				hoverArea.global_position = original_position
				hoverArea.z_index = 1
				#hoverArea.top_level = false
	if event is InputEventMouseMotion and is_dragging:
		hoverArea.global_position = get_viewport().get_mouse_position() - Vector2(16,16)
	pass # Replace with function body.


func find_matching_item(slots: Array[InvSlot]):
	var index = -1
	for i in slots.size():
		if slots[i].item != null and invSlot.item != null:
			if invSlot.item.id == slots[i].item.id:
				index = i
	return index

func _on_hover_area_area_entered(area: Area2D) -> void:
	if not targets.has(area.get_parent()) and area.get_parent().is_in_group("InvSlot") and is_dragging:
		if self.locked or area.get_parent().locked:
			return
		targets.append(area.get_parent())


func _on_hover_area_area_exited(area: Area2D) -> void:
	targets.erase(area.get_parent())
	pass # Replace with function body.
