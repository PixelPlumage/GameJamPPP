extends Panel

@onready var hoverArea = $HoverArea
@onready var item_visuals: Sprite2D = $HoverArea/ItemContainer/Panel/item_display
@onready var amount_text: Label = $HoverArea/ItemContainer/Panel/Label
@export var locked = false
var is_dragging: bool = false
var original_position

var targets: Array[Node] = []

func update(slot: InvSlot):
	if !slot.item:
		
		item_visuals.visible = false
		amount_text.visible = false
	else:
		#print("updating slot", slot.item.name)
		item_visuals.visible = true
		item_visuals.texture = slot.item.texture
		if slot.count > 1:
			amount_text.visible = true
			amount_text.text = str(slot.count)


func _on_gui_input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton:
		if locked:
			return
		if event.pressed:
			is_dragging = true
			original_position = hoverArea.global_position
			#hoverArea.top_level = true
			hoverArea.z_index = 2
		else:
			if targets.size() > 0:
				SignalBus.swapItems.emit(self, targets.back())
			is_dragging = false
			hoverArea.global_position = original_position
			hoverArea.z_index = 1
			#hoverArea.top_level = false
	if event is InputEventMouseMotion and is_dragging:
		hoverArea.global_position = get_viewport().get_mouse_position() - Vector2(16,16)
	pass # Replace with function body.


func _on_hover_area_area_entered(area: Area2D) -> void:
	if not targets.has(area.get_parent()) and area.get_parent().is_in_group("InvSlot") and is_dragging:
		if self.locked or area.get_parent().locked:
			return
		targets.append(area.get_parent())


func _on_hover_area_area_exited(area: Area2D) -> void:
	targets.erase(area.get_parent())
	pass # Replace with function body.
