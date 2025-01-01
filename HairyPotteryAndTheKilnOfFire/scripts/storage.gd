extends Node2D

var is_open: bool = false
var player: Player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_released("e") and player != null:
		SignalBus.toggleStorage.emit(global_position)
		pass
		# toggle_storage()
	pass


func _on_interactable_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
	pass # Replace with function body.


func _on_interactable_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = null
		SignalBus.closeStorage.emit()
	pass # Replace with function body.
