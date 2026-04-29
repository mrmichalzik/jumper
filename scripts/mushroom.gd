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



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var y_delta = position.y - body.position.y
		# Differenz zwischen Gegner- und Spieler-Position.
		# Wenn Spieler von der Seite berührt, ist die Differenz klein,
		# von oben ist die Differenz groß:
		if y_delta < 10: #Ge
			await body.delete()
			body.reset(GameManager.LevelStartZone)
		else: #Gegner stirbt
			skin.play("hit")
			body.bounce(0.8)
			await skin.animation_finished
			queue_free() #Entfernt Gegner aus dem Spiel
