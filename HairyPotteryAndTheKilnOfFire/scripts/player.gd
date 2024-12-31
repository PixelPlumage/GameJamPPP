extends CharacterBody2D

class_name Player


@export var current_dir: String = "none"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("front_idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	player_movement(delta)
	
#region Movement and animation
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
#endregion


func collect(item: InvItem):
	Global.playerData.Inv.insert(item)
