extends Node2D

@onready var SceneTransitionAnimation = $SceneTransitionAnimation/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_cliffside_transition_point_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.transition_scene = true
		SceneTransitionAnimation.play("fade_in")
		call_deferred("change_scene")
		
		
		
func change_scene():
	if Global.transition_scene == true:
		if Global.current_scene == "world":
			await get_tree().create_timer(0.5).timeout
			Global.change_scene("cliff_side")
			
			
