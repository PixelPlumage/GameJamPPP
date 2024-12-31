extends Control

@export var maxSlots: int = 8
@onready var toolbarContainer = $HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.updateInv.connect(update_toolbar)
	SignalBus.selectedSlotChanged.connect(update_selected)
	toolbarContainer.get_child(0).get_node("SelectedBorder").visible = true
	update_toolbar()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func update_toolbar():
	var toolbarSlots = toolbarContainer.get_children()
	var invSlots = Global.playerData.inv.slots.slice(0, maxSlots)
	for i in maxSlots:
		toolbarSlots[i].update(invSlots[i])
		
func update_selected(prev, new):
	var toolbarSlots = toolbarContainer.get_children()
	toolbarSlots[prev].get_node("SelectedBorder").visible = false
	toolbarSlots[new].get_node("SelectedBorder").visible = true
	
