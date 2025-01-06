extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Money/MoneyCount.text = str(Global.gameState.playerData.money)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Money/MoneyCount.text = str(Global.gameState.playerData.money)
	pass
