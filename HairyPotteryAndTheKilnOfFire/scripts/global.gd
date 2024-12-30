extends Node

var scene_paths: Dictionary = {
	"world": "res://scenes/world.tscn",
	"cliff_side": "res://scenes/cliff_side.tscn"
}
var save_file_path = "user://save/"
var player_save_file_name = "PlayerSave.tres"

var transition_scene: bool = false

var player_exit_cliffside_posx: int = 0
var player_exit_cliffside_posy: int = 0
var player_start_posx: int = 0
var player_start_posy: int = 0
var playerData: PlayerData = PlayerData.new()


func load_player_data():
	if not FileAccess.file_exists(save_file_path + player_save_file_name):
		return
	playerData = (await ResourceLoader.load(save_file_path + player_save_file_name)).duplicate(true)
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
