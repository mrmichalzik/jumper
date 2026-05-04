extends Node2D

@onready var startzone: Area2D = $Startzone
@onready var finish_zone: Area2D = $FinishZone

@export var next_level : PackedScene = null

var timer_node = null
var timer_left = 900
var score = 0

const Player = preload("res://scenes/player.tscn")
var player

func _ready() -> void:
	GameManager.LevelStartZone = startzone.global_position
	insert_player(GameManager.LevelStartZone)
	
func insert_player(start_zone):
	player = Player.instantiate()
	add_child(player)
	player.reset(start_zone)
	
func _on_death_zone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player.reset(startzone.global_position)

func _on_jump_pad_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player.jumppadpush()
		$JumpPad.jump()
	## TO-DO: Pilz soll auch geschleudert werden
	if body.is_in_group("Enemy"):
		print("Pilz berührt Jumppad")
		body.velocity.y = 2

func _on_circular_saw_body_entered(body: Node2D) -> void:
	player.reset(GameManager.LevelStartZone)

func _on_finish_zone_body_entered(body: Node2D) -> void:
	if body == player:
		if next_level != null:
			finish_zone.animate()
			await get_tree().create_timer(1.5).timeout
			get_tree().change_scene_to_packed(next_level)
