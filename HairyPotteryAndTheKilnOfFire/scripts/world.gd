extends Node2D

var is_shop_open: bool = false
var shop = preload("res://inventory/shop_ui.tscn")
var createdShop: ShopUI
@onready var ui = $UI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.toggleShop.connect(toggle_shop)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_cliffside_transition_point_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.transition_scene = true
		body.position.y += 10
		call_deferred("change_scene")
		
		
		
func change_scene():
	if Global.transition_scene == true:
		if Global.current_scene == "world":
			Global.change_scene("cliff_side")
			
			
func toggle_shop(inv: Inv) -> void:
	if is_shop_open:
		close_shop()
	else:
		open_shop(inv)
		
func open_shop(inv: Inv):
	print("Opening shop")
	createdShop = shop.instantiate()
	createdShop.inv = inv
	#shop.ready.connect(load_shop)
	is_shop_open = true
	ui.add_child(createdShop)

func close_shop():
	is_shop_open = false
	ui.remove_child(createdShop)
	#shop.ready.disconnect(load_shop)
	createdShop = null
