extends Resource
class_name GameState

@export var currentScene: String
@export var playerData: PlayerData = PlayerData.new()
@export var storage: Array[InvSlot] = [load("res://inventory/debug/test_stored_slot.tres")]


### Future States
# Time of day
# House state
# Villager Interaction State
