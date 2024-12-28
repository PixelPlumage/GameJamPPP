extends Node

var scenes: Dictionary = {
	"world": preload("res://scenes/world.tscn"),
	"cliff_side": preload("res://scenes/cliff_side.tscn")
}

var current_scene: String = "world" #world cliff_side
var transition_scene: bool = false

var player_exit_cliffside_posx: int = 0
var player_exit_cliffside_posy: int = 0
var player_start_posx: int = 0
var player_start_posy: int = 0
var playerData: PlayerData = PlayerData.new()

func change_scene(scene: String) -> void:
	if !scenes.get(scene):
		push_error("Couldn't switch to scene", scene)
		return
	get_tree().change_scene_to_packed(scenes.get(scene))
	finish_change_scene()

func finish_change_scene() -> void:
	if transition_scene == true:
		transition_scene = false
		if current_scene == "world":
			print("updating")
			current_scene = "cliff_side"
		else:
			current_scene = "world"
