extends CharacterBody2D


const SPEED = 70.0
var movingRight = 1
var canSwitch = true

func _physics_process(delta: float) -> void:
	
	if !$RayCast2D.is_colliding() and canSwitch:
		movingRight *= -1
		canSwitch = false
	else:
		canSwitch = true
		
	
	if movingRight < 0:
		velocity.x = SPEED * -1.0
		#$RayCast2D.target_position = Vector2(-270,250) #Warum diese Werte?
	else:
		velocity.x = SPEED * 1
		#$RayCast2D.target_position = Vector2(270,250) #Warum diese Werte?
	
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		await body.delete()
		body.reset(GameManager.LevelStartZone)
