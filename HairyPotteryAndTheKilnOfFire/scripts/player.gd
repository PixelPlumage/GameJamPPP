extends CharacterBody2D

class_name Player

@onready var invUI: InvUI = $Inv_UI

var save_file_path = "user://save/"
var save_file_name = "PlayerSave.tres"

var current_dir: String = "none"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	verify_save_directory(save_file_path)
	$AnimatedSprite2D.play("front_idle")

func verify_save_directory(path: String):
	DirAccess.make_dir_absolute(path)
	
func load_data():
	Global.playerData = ResourceLoader.load(save_file_path + save_file_name).duplicate(true)
	# Arrays don't deep clone, so do the clone here
	for i in Global.playerData.inv.slots.size():
		var newSlot = InvSlot.new()
		newSlot.count = Global.playerData.inv.slots[i].count
		newSlot.item = Global.playerData.inv.slots[i].item
		Global.playerData.inv.slots[i] = newSlot
	position = Global.playerData.SavePos
	# Need to update the ui and reconnect the update signal
	invUI._ready()

func save():
	Global.playerData.UpdatePos(position)
	ResourceSaver.save(Global.playerData, save_file_path + save_file_name)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("save"):
		save()
	if Input.is_action_just_pressed("load"):
		load_data()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	player_movement(delta)
	
func player_movement(delta: float) -> void:
	if Input.is_action_pressed("ui_right") || Input.is_action_pressed("d"):
		current_dir = "right"
		play_anim(1)
		velocity.x = Global.playerData.speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left") || Input.is_action_pressed("a"):
		play_anim(1)
		current_dir = "left"
		velocity.x = -Global.playerData.speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down") || Input.is_action_pressed("s"):
		play_anim(1)
		current_dir = "down"
		velocity.x = 0
		velocity.y = Global.playerData.speed
	elif Input.is_action_pressed("ui_up") || Input.is_action_pressed("w"):
		play_anim(1)
		current_dir = "up"
		velocity.x = 0
		velocity.y = -Global.playerData.speed
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()
	
func play_anim(movement: int) -> void:
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if (dir == "right"):
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		else:
			anim.play("side_idle")
	elif (dir == "left"):
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		else:
			anim.play("side_idle")
	
	if (dir == "down"):
		if movement == 1:
			anim.play("front_walk")
		else:
			anim.play("front_idle")
	elif (dir == "up"):
		if movement == 1:
			anim.play("back_walk")
		else:
			anim.play("back_idle")	


func collect(item: InvItem):
	Global.playerData.Inv.insert(item)
