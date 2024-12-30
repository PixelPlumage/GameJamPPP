extends Node2D

func _on_cliffside_transition_point_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.transition_scene = true
		body.position.y += 10
		call_deferred("change_scene")
		
		
		
func change_scene():
	if Global.transition_scene == true:
		SignalBus.changeScene.emit("cliff_side")
		print("emitting change scene")
		#Global.change_scene("cliff_side")
			
