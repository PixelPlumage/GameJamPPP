extends MarginContainer
class_name ShopUI

@onready var shopItem = preload("res://inventory/shop_item_ui.tscn")
@onready var itemContainer = $ScrollContainer/ItemContainer


var inv: Inv

func _ready() -> void:
	load_shop()
	
func load_shop() -> void:
	for invSlot in inv.slots:
		var item = shopItem.instantiate()
		item.item_cost = str(invSlot.item.cost)
		item.item_name = invSlot.item.name
		item.texture = invSlot.item.texture
		item.item = invSlot.item
		
		itemContainer.add_child(item)
		
