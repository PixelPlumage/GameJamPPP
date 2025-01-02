extends Node

var scene_paths: Dictionary = {
	"world": "res://scenes/world.tscn",
	"cliff_side": "res://scenes/cliff_side.tscn"
}


var transition_scene: bool = false

var player_exit_cliffside_posx: int = 0
var player_exit_cliffside_posy: int = 0
var player_start_posx: int = 0
var player_start_posy: int = 0
var gameState: GameState = GameState.new()

var some_cutscene = false

var is_game_playing: bool = false
var is_shop_open: bool = false
var is_storage_open: bool = false

const MIN_STORAGE = 30

func _ready() -> void:
	if gameState.storage.size() < MIN_STORAGE:
		gameState.storage.resize(MIN_STORAGE)
		for i in gameState.storage.size():
			var newSlot = InvSlot.new()
			newSlot.stored = true
			gameState.storage[i] = newSlot
	SignalBus.swapItems.connect(swap_items)

#region Saving and loading player data

var save_file_path = "user://save/"
var save_file_name = "GameState.tres"

func load_game():
	if not FileAccess.file_exists(save_file_path + save_file_name):
		return
	gameState = ResourceLoader.load(save_file_path + save_file_name, "GameState").duplicate(true)
	# Arrays don't deep clone, so do the clone here
	cloneInvArray(gameState.playerData.inv.slots)
	cloneInvArray(gameState.storage)
	# Need to update the ui and reconnect the update signal
	SignalBus.updateInv.emit()
	SignalBus.updateStorage.emit()

func cloneInvArray(slots: Array[InvSlot]):
	for i in slots.size():
		slots[i] = slots[i].duplicate(true)

func save_game():
	ResourceSaver.save(Global.gameState, save_file_path + save_file_name)

#endregion

func swap_items(slot1: InvSlot, slot2: InvSlot) -> void:
	var firstIndex: int
	var secondIndex: int
	var tempFirstSlot = slot1.duplicate(true)
	var tempSecondSlot = slot2.duplicate(true)
	var merge = is_same_item(slot1, slot2)
	if merge:
		slot2.count += slot1.count
		slot1.item = null
		slot1.count = 0
		SignalBus.updateStorage.emit()
		SignalBus.updateInv.emit()
		return
	if slot1.stored and slot2.stored:
		firstIndex = gameState.storage.find(slot1)
		secondIndex = gameState.storage.find(slot2)
		gameState.storage[firstIndex] = tempSecondSlot
		gameState.storage[secondIndex] = tempFirstSlot
		SignalBus.updateStorage.emit()
	elif slot1.stored or slot2.stored:
		if slot1.stored:
			firstIndex = gameState.storage.find(slot1)
			secondIndex = gameState.playerData.inv.slots.find(slot2)
			tempFirstSlot.stored = false
			tempSecondSlot.stored = true
			gameState.storage[firstIndex] = tempSecondSlot
			gameState.playerData.inv.slots[secondIndex] = tempFirstSlot
			SignalBus.updateStorage.emit()
			SignalBus.updateInv.emit()
		else:
			firstIndex = gameState.playerData.inv.slots.find(slot1)
			secondIndex = gameState.storage.find(slot2)
			tempFirstSlot.stored = true
			tempSecondSlot.stored = false
			gameState.playerData.inv.slots[firstIndex] = tempSecondSlot
			gameState.storage[secondIndex] = tempFirstSlot
			SignalBus.updateStorage.emit()
			SignalBus.updateInv.emit()
		pass
	else:
		firstIndex = gameState.playerData.inv.slots.find(slot1)
		secondIndex = gameState.playerData.inv.slots.find(slot2)
		gameState.playerData.inv.slots[firstIndex] = tempSecondSlot
		gameState.playerData.inv.slots[secondIndex] = tempFirstSlot
		SignalBus.updateInv.emit()

func is_same_item(slot1: InvSlot, slot2: InvSlot):
	if slot1.item == null or slot2.item == null:
		return false
	return slot1.item.id == slot2.item.id
