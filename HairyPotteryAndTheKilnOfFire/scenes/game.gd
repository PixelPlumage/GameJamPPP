extends Node2D

var scene_paths: Dictionary = {
	"world": "res://scenes/world.tscn",
	"cliff_side": "res://scenes/cliff_side.tscn"
}
var save_file_path = "user://save/"

var current_scene: String = "world" #world cliff_side
var current_scene_node: Node2D = null

var is_shop_open: bool = false
var shop = preload("res://inventory/shop_ui.tscn")
var createdShop: ShopUI
@onready var ui = $GameUI
@onready var hud = $HUD

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.toggleShop.connect(toggle_shop)
	SignalBus.closeShop.connect(close_shop)
	SignalBus.changeScene.connect(change_scene)
	current_scene_node = load(scene_paths.get("world")).instantiate()
	Global.load_player_data()
	add_child(current_scene_node)

func _init() -> void:
	for key: String in scene_paths.keys():
		var path = save_file_path + key + ".tscn"
		if ResourceLoader.exists(path):
			var level = path
			scene_paths[key] = level

func change_scene(scene: String) -> void:
	print("in change scene")
	if !scene_paths.get(scene):
		push_error("Couldn't switch to scene", scene)
		return
	print("changing scenes")
	save_current_scene()
	remove_child(current_scene_node)
	current_scene_node = load(scene_paths.get(scene)).instantiate()
	add_child(current_scene_node)
	finish_change_scene()
	

func save_current_scene() -> void:
	var scene = PackedScene.new()
	scene.pack(current_scene_node)
	var path = save_file_path + current_scene + ".tscn"
	if scene_paths[current_scene] !=  path:
		scene_paths[current_scene] = path
	ResourceSaver.save(scene, save_file_path + current_scene + ".tscn")
	Global.save_player()
	

func finish_change_scene() -> void:
	if Global.transition_scene == true:
		Global.transition_scene = false
		if current_scene == "world":
			current_scene = "cliff_side"
		else:
			current_scene = "world"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func toggle_shop(inv: Inv) -> void:
	if is_shop_open:
		close_shop()
	else:
		open_shop(inv)
		
func open_shop(inv: Inv):
	print("Opening shop")
	createdShop = shop.instantiate()
	createdShop.inv = inv
	#shop.ready.connect(load_shop)
	is_shop_open = true
	ui.add_child(createdShop)
	ui.layer = 1
	hud.layer = 0

func close_shop():
	is_shop_open = false
	ui.remove_child(createdShop)
	#shop.ready.disconnect(load_shop)
	createdShop = null
	hud.layer = 1

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_current_scene()
