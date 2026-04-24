extends Node2D

@onready var startzone: Area2D = $Startzone
@onready var finish_zone: Area2D = $FinishZone

@export var next_level : PackedScene = null

var timer_node = null
var timer_left = 900

const Player = preload("res://scenes/player.tscn")
var player

func _ready() -> void:
	insert_player()
	timer_node = Timer.new()
	timer_node.wait_time = 1
	add_child(timer_node)
	timer_node.timeout.connect(_on_level_timer_timeout)
	timer_node.start()
	
func _on_level_timer_timeout():
	print("Timer timeout")
	timer_left -= 1
	$HUD.set_time_label(timer_left)
	if timer_left <= 0:
		player.reset(startzone.global_position)
	
func insert_player():
	print("Level setzt Player ein.")
	player = Player.instantiate()
	add_child(player)
	player.reset(startzone.global_position)
	

func _on_death_zone_body_entered(body: Node2D) -> void:
	print(body.name, " ist runtergefallen.")
	if body.name == "Player":
		player.reset(startzone.global_position)

func _on_jump_pad_body_entered(body: Node2D) -> void:
	print("Jump! Dum, dum, dum ...")
	if body.name == "Player":
		player.jumppadpush();
		$JumpPad.jump();


func _on_circular_saw_body_entered(body: Node2D) -> void:
	player.reset(startzone.global_position)


func _on_finish_zone_body_entered(body: Node2D) -> void:
	if body == player:
		if next_level != null:
			print("Tada")
			finish_zone.animate()
			await get_tree().create_timer(1.5).timeout
			get_tree().change_scene_to_packed(next_level)
	


func _on_circular_saw_2_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
