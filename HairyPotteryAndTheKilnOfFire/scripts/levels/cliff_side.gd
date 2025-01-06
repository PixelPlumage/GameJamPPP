extends Node2D

var player: CharacterBody2D

func _on_exit_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.transition_scene = true
		body.position.y -= 10
		call_deferred("switch_level")
		

func switch_level() -> void:
	SignalBus.changeScene.emit("world")
