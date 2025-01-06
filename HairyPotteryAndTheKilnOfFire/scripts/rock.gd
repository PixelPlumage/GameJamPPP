extends Node2D

var player_in_area = false
var player: Player
@export var item: InvItem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player_in_area:
		if Input.is_action_just_pressed("e"):
			Global.gameState.playerData.inv.insert(item)
			queue_free()
	pass


func _on_pickable_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_area = true
		player = body


func _on_pickable_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_area = false
		player = null
