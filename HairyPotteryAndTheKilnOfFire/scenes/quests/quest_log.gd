extends Control
class_name QuestLogUI

@onready var questContainer = $Panel/QuestContainer
@onready var label = $Panel/QuestContainer/Label
@onready var questUI = preload("res://scenes/quests/quest_ui.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.updateQuestLog.connect(update_quest_log)
	update_quest_log()
	pass # Replace with function body.


func update_quest_log() -> void:
	if Global.questManager.ownedQuests.size() == 0:
		label.visible = true
		questContainer.set_anchors_preset(LayoutPreset.PRESET_HCENTER_WIDE, true)
		pass
	else:
		label.visible = false
		questContainer.set_anchors_preset(LayoutPreset.PRESET_FULL_RECT)
		questContainer.position.y = 0
	for quest in Global.questManager.ownedQuests:
		print(quest.description)
		var newQuest = questUI.instantiate()
		newQuest.quest = quest
		questContainer.add_child(newQuest)
		pass
