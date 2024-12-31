extends Node2D

@onready var fireMeter = $CanvasLayer/FireMeter
@onready var leftMarker = $LeftMarker
@onready var rightMarker = $RightMarker
@onready var fireSprite = $FireSprite
@onready var progressBar = $CanvasLayer/ProgressBar
@onready var hotZone = $CanvasLayer/HotZone

@export var heatSpeed: float
@export var closeness: int = 16
@export var progressSpeed: int = 10
@export var hotZoneSpeed: float = 50
@export var zoneThinkTime: float = 3

var zoneTimer = 0
var zoneTargetPos: float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	zoneTargetPos = hotZone.position.x
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if progressBar.value == 100:
		print("winner")
		queue_free()
		return
	if progressBar.value == 0:
		print("Game Over!")
		queue_free()
		return
	moveHotZone(delta)
	if Input.is_action_pressed("cook"):
		#print("cooking")
		fireSprite.self_modulate = "ffffff"
		fireSprite.play()
		fireMeter.size.x = min(fireMeter.size.x + heatSpeed * delta, rightMarker.position.x - leftMarker.position.x)
	else:
		#print("cooling")
		fireSprite.self_modulate = "0cded141"
		fireSprite.stop()
		fireMeter.size.x = max(0,fireMeter.size.x - heatSpeed * delta)
	var zoneTime = is_in_hot_zone()
	if zoneTime:
		progressBar.value = progressBar.value + progressSpeed * delta
	else:
		progressBar.value = progressBar.value - progressSpeed * delta

func calculateNormalized(pos: Vector2):
	var totalLength = rightMarker.position.x - leftMarker.position.x

func is_in_hot_zone():
	var heatPos = fireMeter.size.x + leftMarker.position.x
	var zonePos = hotZone.position.x
	if heatPos >= zonePos - closeness and heatPos <= zonePos + closeness:
		return true
	else:
		return false
	
func moveHotZone(delta: float):
	zoneTimer -= delta
	if zoneTimer <= 0:
		zoneTimer = zoneThinkTime
		zoneTargetPos = randf_range(leftMarker.position.x, rightMarker.position.x)
	hotZone.position.x = lerp(float(hotZone.position.x), zoneTargetPos, 0.005)
	pass
