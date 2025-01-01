extends StaticBody2D
class_name ShopKeeper

var player: Player
@export var inv: Inv
var shop: ShopUI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player != null:
		if Input.is_action_just_pressed("e"):
			toggle_shop()
			print("Player interacted")
	pass


func _on_interactable_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if (event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT):
		if player != null:
			print("player clicked me in range")
			print(Global.gameState.playerData.money)
			toggle_shop()


func _on_interactable_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body


func _on_interactable_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = null
		SignalBus.closeShop.emit()
	pass # Replace with function body.
	
func toggle_shop() -> void:
	SignalBus.toggleShop.emit(inv)
