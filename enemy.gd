extends CharacterBody2D


const SPEED = 70
var movingRight = 1
var canSwitch = true
@onready var skin: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	
	if !$RayCast2D.is_colliding() and canSwitch:
		movingRight *= -1
		canSwitch = false
	else:
		canSwitch = true
		
	
	if movingRight < 0:
		velocity.x = SPEED * -1.0
		skin.flip_h = false
		
		$RayCast2D.target_position = Vector2(-6,20) #Warum diese Werte?
	else:
		velocity.x = SPEED * 1
		skin.flip_h = true
		$RayCast2D.target_position = Vector2(6,20) #Warum diese Werte?
	
	move_and_slide()

#func _on_kill_zone_body_entered(body: Node2D) -> void:
	#if body.is_in_group("Player"):
		#body.move_local_y(-20)
		##set_physics_process(false)
		##$KillZone/CollisionShape2D.disabled = true
		#skin.play("hit")
		#await skin.animation_finished
		#queue_free() #Entfernt die Frücht komplett


func _on_hurt_player_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		await body.delete()
		body.reset(GameManager.LevelStartZone)
