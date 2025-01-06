extends Node


#region UI signals
@warning_ignore("unused_signal")
signal toggleShop(inv: Inv)
@warning_ignore("unused_signal")
signal closeShop()
@warning_ignore("unused_signal")
signal toggleStorage(position: Vector2)
@warning_ignore("unused_signal")
signal closeStorage
@warning_ignore("unused_signal")
signal openInv
@warning_ignore("unused_signal")
signal updateInv
@warning_ignore("unused_signal")
signal updateStorage
@warning_ignore("unused_signal")
signal swapItems(slot1, slot2)
@warning_ignore("unused_signal")
signal selectedSlotChanged(prev, new)
@warning_ignore("unused_signal")
signal toggleQuestLog
@warning_ignore("unused_signal")
signal closeQuestLog
@warning_ignore("unused_signal")
signal updateQuestLog
#endregion

#region Scene and save data management
@warning_ignore("unused_signal")
signal changeScene(scene: String)
@warning_ignore("unused_signal")
signal newGame
@warning_ignore("unused_signal")
signal loadGame
@warning_ignore("unused_signal")
signal saveGame
#endregion
