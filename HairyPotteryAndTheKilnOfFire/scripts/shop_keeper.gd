extends StaticBody2D
class_name ShopKeeper

var player: Player
var Inv: Inv

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player != null:
		if Input.is_action_just_pressed("e"):
			print("Player interacted")
	pass


func _on_interactable_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT):
		if player != null:
			print("player clicked me in range")
			print(Global.playerData.money)


func _on_interactable_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body


func _on_interactable_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = null
	pass # Replace with function body.
