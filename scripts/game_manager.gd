extends Node

var timer_node = null
var time = 0
var fruits = 0
var LevelStartZone

@onready var hud: CanvasLayer = $HUD


func _process(delta: float) -> void:
	hud.set_fruits(fruits)


func _ready() -> void:
	hud.set_time(0)
	timer_node = Timer.new()
	timer_node.wait_time = 1
	add_child(timer_node)
	timer_node.timeout.connect(_on_level_timer_timeout)
	timer_node.start()
	
func _on_level_timer_timeout():
	time += 1
	hud.set_time(time)
