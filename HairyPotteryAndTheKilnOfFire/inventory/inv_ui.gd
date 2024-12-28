extends Control
class_name InvUI

@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open: bool = false

func _ready() -> void:
	update_slots()
	Global.playerData.inv.update.connect(update_slots)
	close()

func update_slots() -> void:
	for i in range(min(Global.playerData.inv.slots.size(), slots.size())):
		slots[i].update(Global.playerData.inv.slots[i])
	
func _process(delta: float) -> void:
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
