extends Resource
class_name Quest

@export var id: int
@export var name: String
@export var description: String
@export var objectives: Array[QuestObjective]
@export var completed_objectives: Array[QuestObjective]
@export var current_objective: QuestObjective = null
@export var reward: QuestReward
