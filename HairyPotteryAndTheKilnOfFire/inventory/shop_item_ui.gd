extends PanelContainer
class_name ShopItem

@onready var item_sprite = $MarginContainer/HBoxContainer/HBoxContainer2/ItemTexture
@onready var item_name_label = $MarginContainer/HBoxContainer/HBoxContainer2/ItemName
@onready var item_cost_label = $MarginContainer/HBoxContainer/HBoxContainer/CostLabel

var texture: Texture2D
var item_cost: int
var item_name: String

func _ready() -> void:
	item_sprite.texture = texture
	item_name_label.text = item_name
	item_cost_label.text = str(item_cost)
	
func _process(delta: float) -> void:
	if Global.playerData.money < item_cost:
		item_cost_label.add_theme_color_override("font_color", Color.RED)
