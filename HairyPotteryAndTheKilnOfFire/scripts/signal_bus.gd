extends Node
@warning_ignore("unused_signal")

signal toggleShop(inv: Inv)
signal closeShop()
signal toggleStorage(position: Vector2)
signal closeStorage
signal changeScene(scene: String)
signal updateInv
signal updateStorage
signal newGame
signal loadGame
signal saveGame
signal swapItems(slot1, slot2)
signal selectedSlotChanged(prev, new)
