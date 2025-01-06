extends Node2D

var cur_player = null
var in_dialogue = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("teapot_blink")
	Dialogic.timeline_ended.connect(fade_away)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if cur_player:
		if Input.is_action_pressed("e") and !in_dialogue:
			in_dialogue = true
			Dialogic.start("teapotGiving")
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		cur_player = body
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		cur_player = null
	pass # Replace with function body.


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if(anim_name == "teapot_fade"):
		queue_free()
	pass # Replace with function body.

func fade_away():
	$AnimationPlayer.play("teapot_fade")
