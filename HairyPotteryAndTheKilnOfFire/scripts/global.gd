extends Node

var scene_paths: Dictionary = {
	"world": "res://scenes/world.tscn",
	"cliff_side": "res://scenes/cliff_side.tscn"
}
var save_file_path = "user://save/"
var player_save_file_name = "PlayerSave.tres"
var storage_save_file_name = "Storage.tres"

var transition_scene: bool = false

var player_exit_cliffside_posx: int = 0
var player_exit_cliffside_posy: int = 0
var player_start_posx: int = 0
var player_start_posy: int = 0
var playerData: PlayerData = PlayerData.new()
var storage: Array[InvSlot] = [load("res://inventory/debug/test_stored_slot.tres")]


var is_game_playing: bool = false
var is_shop_open: bool = false
var is_storage_open: bool = false

const MIN_STORAGE = 30

func _ready() -> void:
	if storage.size() < MIN_STORAGE:
		storage.resize(MIN_STORAGE)
		for i in storage.size() -1:
			var newSlot = InvSlot.new()
			newSlot.stored = true
			storage[i+1] = newSlot
	SignalBus.swapItems.connect(swap_items)

#region Saving and loading player data

func load_player_data():
	if not FileAccess.file_exists(save_file_path + player_save_file_name):
		return
	playerData = ResourceLoader.load(save_file_path + player_save_file_name).duplicate(true)
	# Arrays don't deep clone, so do the clone here
	for i in playerData.inv.slots.size():
		var newSlot = InvSlot.new()
		newSlot.count = playerData.inv.slots[i].count
		newSlot.item = playerData.inv.slots[i].item
		playerData.inv.slots[i] = newSlot
	# Need to update the ui and reconnect the update signal
	SignalBus.updateInv.emit()

func save_player():
	ResourceSaver.save(Global.playerData, save_file_path + player_save_file_name)

func save_storage():
	#ResourceSaver.save(storage, save_file_path + storage_save_file_name)
	pass
#endregion

func swap_items(slot1: InvSlot, slot2: InvSlot) -> void:
	var firstIndex: int
	var secondIndex: int
	var tempFirstSlot = slot1.duplicate()
	var tempSecondSlot = slot2.duplicate()
	if slot1.stored and slot2.stored:
		firstIndex = Global.storage.find(slot1)
		secondIndex = Global.storage.find(slot2)
		Global.storage[firstIndex] = tempSecondSlot
		Global.storage[secondIndex] = tempFirstSlot
		SignalBus.updateStorage.emit()
	elif slot1.stored or slot2.stored:
		if slot1.stored:
			firstIndex = Global.storage.find(slot1)
			secondIndex = Global.playerData.inv.slots.find(slot2)
			tempFirstSlot.stored = false
			tempSecondSlot.stored = true
			Global.storage[firstIndex] = tempSecondSlot
			Global.playerData.inv.slots[secondIndex] = tempFirstSlot
			SignalBus.updateStorage.emit()
			SignalBus.updateInv.emit()
		else:
			firstIndex = Global.playerData.inv.slots.find(slot1)
			secondIndex = Global.storage.find(slot2)
			tempFirstSlot.stored = true
			tempSecondSlot.stored = false
			Global.playerData.inv.slots[firstIndex] = tempSecondSlot
			Global.storage[secondIndex] = tempFirstSlot
			SignalBus.updateStorage.emit()
			SignalBus.updateInv.emit()
		pass
	else:
		firstIndex = Global.playerData.inv.slots.find(slot1)
		secondIndex = Global.playerData.inv.slots.find(slot2)
		Global.playerData.inv.slots[firstIndex] = tempSecondSlot
		Global.playerData.inv.slots[secondIndex] = tempFirstSlot
		SignalBus.updateInv.emit()

var current_cutscene
var some_cutscene = false
