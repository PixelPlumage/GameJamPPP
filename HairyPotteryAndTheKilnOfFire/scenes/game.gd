extends Node2D

var scene_path_defaults: Dictionary = {
	"world": "res://scenes/levels/world.tscn",
	"cliff_side": "res://scenes/levels/cliff_side.tscn"
}
var scene_paths: Dictionary = scene_path_defaults.duplicate()

var save_file_path = "user://save/"

var current_scene: String = "world" #world cliff_side
var current_scene_node: Node2D = null

var shop = preload("res://inventory/shop_ui.tscn")
var createdShop: ShopUI

var storage = preload("res://scenes/ui/storage_ui.tscn")
var createdStorage: StorageUI

var questLog = preload("res://scenes/quests/quest_log.tscn")
var createdQuestLog: QuestLogUI

@onready var ui = $GameUI
@onready var hud = $HUD
@onready var menu = $Menu

var is_menu_open: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.toggleShop.connect(toggle_shop)
	SignalBus.closeShop.connect(close_shop)
	SignalBus.toggleStorage.connect(toggle_storage)
	SignalBus.closeStorage.connect(close_storage)
	SignalBus.changeScene.connect(change_scene)
	SignalBus.toggleQuestLog.connect(toggle_quest_log)
	SignalBus.closeQuestLog.connect(close_quest_log)
	
	SignalBus.loadGame.connect(load_game)
	SignalBus.newGame.connect(new_game)
	SignalBus.saveGame.connect(save_current_scene)
	Dialogic.signal_event.connect(add_quest)

func _init() -> void:
	for key: String in scene_paths.keys():
		var path = save_file_path + key + ".tscn"
		if ResourceLoader.exists(path):
			var level = path
			scene_paths[key] = level
			
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause") and is_menu_open:
		menu.visible = false
		is_menu_open = false
	elif event.is_action_pressed("Pause") and !is_menu_open:
		menu.get_node("MainMenu/NinePatchRect/VBoxContainer/Continue").visible = false
		menu.get_node("MainMenu/NinePatchRect/VBoxContainer/NewGame").visible = false
		menu.visible = true
		is_menu_open = true
	

#region Saving/Loading Logic
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
	if current_scene_node == null:
		return
	var scene = PackedScene.new()
	scene.pack(current_scene_node)
	var path = save_file_path + current_scene + ".tscn"
	if scene_paths[current_scene] !=  path:
		scene_paths[current_scene] = path
	ResourceSaver.save(scene, path)
	Global.save_game()
	

func finish_change_scene() -> void:
	if Global.transition_scene == true:
		Global.transition_scene = false
		if current_scene == "world":
			current_scene = "cliff_side"
		else:
			current_scene = "world"
			
func load_game(is_new_game: bool = false) -> void:
	current_scene_node = load(scene_paths.get("world")).instantiate()
	if !is_new_game:
		Global.load_game()
	ui.visible = true
	hud.visible = true
	menu.visible = false
	is_menu_open = false
	Global.is_game_playing = true
	add_child(current_scene_node)

func new_game() -> void:
	scene_paths = scene_path_defaults.duplicate()
	load_game(true)
	
func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_current_scene()
#endregion

#region Shop Logic
func toggle_shop(inv: Inv) -> void:
	if Global.is_shop_open:
		close_shop()
	else:
		open_shop(inv)
		
func open_shop(inv: Inv):
	print("Opening shop")
	createdShop = shop.instantiate()
	createdShop.inv = inv
	#shop.ready.connect(load_shop)
	Global.is_shop_open = true
	ui.add_child(createdShop)
	ui.layer = 1
	hud.layer = 0

func close_shop():
	Global.is_shop_open = false
	if createdShop != null:
		ui.remove_child(createdShop)
	#shop.ready.disconnect(load_shop)
	createdShop = null
	hud.layer = 1
#endregion

#region Storage Logic
func toggle_storage(storagePosition: Vector2):
	if !Global.is_storage_open:
		open_storage(storagePosition)
	else:
		close_storage()
		
func open_storage(_storagePosition: Vector2):
	createdStorage = storage.instantiate()
	createdStorage.global_position.y = 150
	Global.is_storage_open = true
	hud.add_child(createdStorage)
	SignalBus.openInv.emit()
	
func close_storage():
	print("close storage")
	if !Global.is_storage_open:
		return
	Global.is_storage_open = false
	if createdStorage != null:
		hud.remove_child(createdStorage)
#endregion

#region Quest Log Logic
func toggle_quest_log():
	if !Global.is_quest_log_open:
		open_quest_log()
	else:
		close_quest_log()

func open_quest_log():
	createdQuestLog = questLog.instantiate()
	Global.is_quest_log_open = true
	hud.add_child(createdQuestLog)
		
	pass

func close_quest_log():
	if !Global.is_quest_log_open:
		return
	Global.is_quest_log_open = false
	if createdQuestLog != null:
		hud.remove_child(createdQuestLog)
	pass
	
func add_quest(questId: String):
	print(questId)
	print("adding quest")
	Global.questManager.addQuest(0)
#endregion
