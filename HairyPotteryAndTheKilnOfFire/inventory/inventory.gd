extends Resource

class_name Inv



@export var slots: Array[InvSlot] = []

func insert(item: InvItem):
	var itemslots = slots.filter(func(slot): return slot.item != null and slot.item.id == item.id)
	if !itemslots.is_empty():
		itemslots[0].count += 1
	else:
		var emptyslots = slots.filter(func(slot): return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].count = 1
	SignalBus.updateInv.emit()
