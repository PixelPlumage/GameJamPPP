extends Node2D

var current_cutscene = "none"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Global.current_cutscene = current_cutscene
	
	if Global.some_cutscene == true:
		if current_cutscene == "none":
			current_cutscene = "some_cutscene"
	pass
