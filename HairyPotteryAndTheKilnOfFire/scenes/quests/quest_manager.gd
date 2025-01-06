extends Node2D
class_name QuestManager

var ownedQuests: Array[Quest] = []
var activeQuest: Quest = null
@export var allQuests: Array[Quest]

func addQuest(id: int) -> void:
	print("firstQuestId: ", allQuests[0].id)
	var foundQuest = allQuests.filter(func(cur): return cur.id == id)
	if ownedQuests.has(foundQuest):
		print("Quest already owned")
		return
	else:
		ownedQuests.append(foundQuest[0])
		print("Owned quest size ater adding", ownedQuests.size())
	SignalBus.updateQuestLog.emit()
	
	
func removeQuest(id: int) -> void:
	var foundQuest = ownedQuests.filter(func(cur): return cur.id == id)
	if foundQuest == null:
		print("Don't have quest to remove")
	else:
		ownedQuests.erase(foundQuest)
		
func updateQuest(id: int, objective_index: int) -> void:
	var foundQuest: Array[Quest] = ownedQuests.filter(func(cur): return cur.id == id)
	if foundQuest.size() == 0:
		print("didn't have quest to update")
	else:
		var completedObjective = foundQuest[0].objectives[objective_index]
		if objective_index == foundQuest[0].objectives.size() - 1:
			completeQuest(foundQuest[0])
		else:
			var nextObjective = foundQuest[0].objectives[objective_index + 1]
			foundQuest[0].objectives.remove_at(objective_index)
			foundQuest[0].completed_objectives.append(completedObjective)
			foundQuest[0].current_objective = nextObjective

func completeQuest(quest: Quest) -> void:
	print("Quest completed")
	ownedQuests.erase(quest)
	pass
