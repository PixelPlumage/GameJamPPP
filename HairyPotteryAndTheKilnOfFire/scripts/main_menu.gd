extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_new_game_pressed() -> void:
	$ConfirmationDialog.visible = true
	#SignalBus.newGame.emit()
	pass # Replace with function body.


func _on_continue_pressed() -> void:
	SignalBus.loadGame.emit()
	pass # Replace with function body.


func _on_exit_game_pressed() -> void:
	SignalBus.saveGame.emit()
	get_tree().quit()
	pass # Replace with function body.


func _on_confirmation_dialog_confirmed() -> void:
	$ConfirmationDialog.visible = false
	SignalBus.newGame.emit()
	pass # Replace with function body.


func _on_confirmation_dialog_canceled() -> void:
	$ConfirmationDialog.visible = false
	pass # Replace with function body.
