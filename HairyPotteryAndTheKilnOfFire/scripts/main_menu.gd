extends Control


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
