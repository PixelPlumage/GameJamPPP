extends Node2D

var player: CharacterBody2D
@onready var SceneTransitionAnimation = $SceneTransitionAnimation/AnimationPlayer

func _on_exit_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		SceneTransitionAnimation.play("fade_in")
		Global.transition_scene = true
		call_deferred("switch_level")
		

func switch_level() -> void:
	Global.finish_change_scene()
	await get_tree().create_timer(0.5).timeout
	SceneLoader.load_scene("res://scenes/world.tscn")
