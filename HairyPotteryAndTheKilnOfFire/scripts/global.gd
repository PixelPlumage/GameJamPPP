extends Node

var scene_paths: Dictionary = {
	"world": "res://scenes/world.tscn",
	"cliff_side": "res://scenes/cliff_side.tscn"
}
var save_file_path = "user://save/"

var current_scene: String = "world" #world cliff_side
var transition_scene: bool = false

var player_exit_cliffside_posx: int = 0
var player_exit_cliffside_posy: int = 0
var player_start_posx: int = 0
var player_start_posy: int = 0
var playerData: PlayerData = PlayerData.new()


func _init() -> void:
	for key: String in scene_paths.keys():
		var path = save_file_path + key + ".tscn"
		if ResourceLoader.exists(path):
			var level = path
			scene_paths[key] = level

func change_scene(scene: String) -> void:
	if !scene_paths.get(scene):
		push_error("Couldn't switch to scene", scene)
		return
	
	save_current_scene()
	get_tree().change_scene_to_file(scene_paths.get(scene))
	finish_change_scene()
	

func save_current_scene() -> void:
	var scene = PackedScene.new()
	scene.pack(get_tree().get_current_scene())
	var path = save_file_path + current_scene + ".tscn"
	if scene_paths[current_scene] !=  path:
		scene_paths[current_scene] = path
	ResourceSaver.save(scene, save_file_path + current_scene + ".tscn")
	

func finish_change_scene() -> void:
	if transition_scene == true:
		transition_scene = false
		if current_scene == "world":
			current_scene = "cliff_side"
		else:
			current_scene = "world"
