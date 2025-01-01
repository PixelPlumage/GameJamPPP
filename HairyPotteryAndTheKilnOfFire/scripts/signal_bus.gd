extends Node
@warning_ignore("unused_signal")

#region Inventory and shop UI
signal toggleShop(inv: Inv)
signal closeShop()
signal toggleStorage(position: Vector2)
signal closeStorage
signal updateInv
signal updateStorage
signal swapItems(slot1, slot2)
signal selectedSlotChanged(prev, new)
#endregion

#region Scene and save data management
signal changeScene(scene: String)
signal newGame
signal loadGame
signal saveGame
#endregion
