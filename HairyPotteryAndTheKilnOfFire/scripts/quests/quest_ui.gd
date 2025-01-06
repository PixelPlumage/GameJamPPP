extends Control
class_name QuestUI

var questNameLabel 
var questInfoPanel

var quest: Quest


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	questNameLabel = $QuestContainer/QuestName
	questInfoPanel = $QuestContainer/QuestInfo
	questNameLabel.text = quest.name
	for i in quest.completed_objectives.size():
		var newLabel = Label.new()
		newLabel.text = quest.completed_objectives[i].objectiveText
		questInfoPanel.add_child(newLabel)
	for i in quest.objectives.size():
		var newLabel = Label.new()
		newLabel.text = quest.objectives[i].objectiveText
		questInfoPanel.add_child(newLabel)
	var newLabel = Label.new()
	newLabel.text = "Reward: " + str(quest.reward.itemId)
	questInfoPanel.add_child(newLabel)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_quest_name_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_released() and event.button_index == MOUSE_BUTTON_LEFT:
		questInfoPanel.visible = !questInfoPanel.visible
	$".".update_minimum_size()
	pass # Replace with function body.
