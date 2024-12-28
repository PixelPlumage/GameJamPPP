extends Node


var current_scene: String = "world" #world cliff_side
var transition_scene: bool = false

var player_exit_cliffside_posx: int = 0
var player_exit_cliffside_posy: int = 0
var player_start_posx: int = 0
var player_start_posy: int = 0

func finish_change_scene() -> void:
	if transition_scene == true:
		transition_scene = false
		if current_scene == "world":
			print("updating")
			current_scene = "cliff_side"
		else:
			current_scene = "world"
